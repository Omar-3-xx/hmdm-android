#!/usr/bin/env bash
# 6.51 — the rep saw "Push notifications are active" in the pull-down (owner, 9 Nov 2026: "hide the Push
# notifications are active notice"). It is the foreground notice of PushLongPollingService, the instant line
# to the server (pushOptions=polling over 443) that brings lock, wipe and config changes in seconds. Android 12
# cannot run that service without a notice, so the owner chose "quiet it, keep instant":
#   G1. PushLongPollingService.startAsForeground creates its channel at IMPORTANCE_LOW (2) instead of
#       DEFAULT (3): no status-bar icon, no sound, no pop-up; it sits under Silent. Android lets an app lower
#       an existing channel's importance while the user has not touched it, so tablets already holding the
#       channel at 3 drop to 2 on the next start. (MIN would be bumped back to LOW for a foreground service.)
#   G2. The notice text (string mqtt_service_text, shared with the unused MqttService) reads "Sato Pharma".
set -euo pipefail
OUT="${1:?decompiled dir}"

# ---- G1: channel importance 3 -> 2 inside startAsForeground ------------------------------------------
P="$OUT/smali/com/hmdm/launcher/service/PushLongPollingService.smali"
[ -f "$P" ] || { echo "::error::PushLongPollingService.smali not found"; exit 1; }
HDR='.method private startAsForeground()V'
n=$(grep -cxF -- "$HDR" "$P" || true)
[ "$n" = "1" ] || { echo "::error::G1: expected exactly 1 startAsForeground, found $n"; exit 1; }
# Within that method only: the `const/4 vX, 0x3` immediately preceding the NotificationChannel <init> becomes 0x2.
awk -v hdr="$HDR" '
  { lines[NR]=$0 }
  END {
    for (i=1;i<=NR;i++) {
      if (lines[i]==hdr) inm=1
      if (inm && lines[i] ~ /^\.end method/) inm=0
      if (inm && lines[i] ~ /Landroid\/app\/NotificationChannel;-><init>\(Ljava\/lang\/String;Ljava\/lang\/CharSequence;I\)V/) {
        for (j=i-1;j>0;j--) { if (lines[j] ~ /^[[:space:]]*$/ || lines[j] ~ /^[[:space:]]*\.line/) continue; break }
        if (lines[j] ~ /^[[:space:]]*const\/4 v[0-9]+, 0x3$/) { sub(/0x3$/, "0x2", lines[j]); done++ }
        else { print "::error::G1: expected const/4 vX, 0x3 before the channel init, got: " lines[j] > "/dev/stderr"; exit 1 }
      }
    }
    if (done!=1) { print "::error::G1: edited " done+0 " channel inits, expected 1" > "/dev/stderr"; exit 1 }
    for (i=1;i<=NR;i++) print lines[i]
  }
' "$P" > "$P.tmp" && mv "$P.tmp" "$P"
awk -v hdr="$HDR" '$0==hdr{m=1} m&&/^\.end method/{exit} m' "$P" | grep -n -B1 "NotificationChannel;-><init>" | head -4
echo "G1 done (push channel LOW)"

# ---- G2: the notice text ------------------------------------------------------------------------------
found=0
for f in "$OUT"/res/values*/strings.xml; do
  if grep -q 'name="mqtt_service_text"' "$f"; then
    sed -i -E 's|(<string name="mqtt_service_text">)[^<]*(</string>)|\1Sato Pharma\2|' "$f"
    grep -n 'name="mqtt_service_text"' "$f"
    found=$((found+1))
  fi
done
[ "$found" -ge 1 ] || { echo "::error::G2: mqtt_service_text not found"; exit 1; }
if grep -rn "Push notifications are active" "$OUT"/res/values*/strings.xml; then echo "::error::G2: old text still present"; exit 1; fi
echo "G2 done (notice reads Sato Pharma, $found locale file(s))"
