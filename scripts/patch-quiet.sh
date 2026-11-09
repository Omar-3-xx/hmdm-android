#!/usr/bin/env bash
# 6.50 — the two things 6.49 left broken on PHX-TAB-0009 (owner, 9 Nov 2026: "rustdesk opens when restart,
# the quick setting is not appearing"). Applied on a FRESH decompile, after patch-statusbar.sh:
#   D. Utils.startRemoteAccessApp  -> return at once. It opened RustDesk's own screen with startActivity on
#      every boot (device log: "Remote access app started: com.carriez.flutter_hbb" one second after
#      BOOT_RECEIVER). A rep must never see a remote-control app pop up, and the owner ordered RustDesk
#      never to start at boot. RustDesk stays installed; it runs only when someone opens it.
#   E. ProUtils.preventStatusBarExpansion -> return null. This is the THIRD pull-down blocker: a touch-eating
#      window across the top of the screen, drawn whenever the rules say blockStatusBar. 6.49 removed the
#      other two (the DPM disable and StatusBarOverlayService), so the shade stayed dead while the Anti
#      Infective rules still said block. With this gone the shade no longer depends on that switch.
set -euo pipefail
OUT="${1:?decompiled dir}"

# Insert BODY (lines split by "|") right after the `.locals` line of the ONE method whose header line is
# exactly HEADER. Exact string match on purpose: awk rewrites backslash escapes passed with -v, so a regex
# built from a smali signature would silently stop matching.
neuter() {
  local file="$1" header="$2" body="$3" label="$4"
  local n
  n=$(grep -cxF -- "$header" "$file" || true)
  if [ "$n" != "1" ]; then echo "::error::$label: expected exactly 1 method '$header' in $file, found $n"; exit 1; fi
  awk -v hdr="$header" -v body="$body" '
    { print }
    $0 == hdr { inm=1; next }
    inm && /^[[:space:]]*\.locals[[:space:]]/ { n=split(body, L, "|"); for(i=1;i<=n;i++) print "    " L[i]; print ""; inm=0; done=1 }
    END { if (!done) { print "::error::no .locals line after the method header" > "/dev/stderr"; exit 1 } }
  ' "$file" > "$file.tmp" && mv "$file.tmp" "$file"
  # prove: the first instruction after .locals is now ours
  awk -v hdr="$header" -v first="${body%%|*}" '
    $0 == hdr { inm=1; next }
    inm && /^[[:space:]]*\.locals/ { want=1; next }
    want && $0 !~ /^[[:space:]]*$/ { line=$0; gsub(/^[[:space:]]+/, "", line); if (line == first) ok=1; want=0; inm=0 }
    END { if (!ok) { print "::error::edit did not land"; exit 1 } }
  ' "$file"
  echo "$label done"
}

# ---- Edit D: RustDesk never auto-opens ----------------------------------------------------------
U="$OUT/smali/com/hmdm/launcher/util/Utils.smali"
[ -f "$U" ] || { echo "::error::Utils.smali not found"; exit 1; }
neuter "$U" '.method public static startRemoteAccessApp(Landroid/content/Context;Ljava/lang/String;)V' 'return-void' 'edit D (RustDesk auto-open)'

# ---- Edit E: no touch-eating window over the status bar ------------------------------------------
P="$(grep -rlE '^\.method .*static .*preventStatusBarExpansion\(' "$OUT"/smali* | head -1 || true)"
[ -n "$P" ] || { echo "::error::preventStatusBarExpansion not found"; exit 1; }
HDR="$(grep -E '^\.method .*static .*preventStatusBarExpansion\(' "$P")"
echo "preventStatusBarExpansion: $P :: $HDR"
# It must take at least one object parameter (p0) and return an object, so `return-object p0` after
# nulling p0 is valid whatever .locals says.
echo "$HDR" | grep -qE 'preventStatusBarExpansion\(L[^;]+;.*\)L[^;]+;$' || { echo "::error::unexpected signature: $HDR"; exit 1; }
neuter "$P" "$HDR" 'const/4 p0, 0x0|return-object p0' 'edit E (status-bar touch blocker)'

echo "----- callers of preventStatusBarExpansion (must null-check the result) -----"
grep -rn -A8 --include='*.smali' 'preventStatusBarExpansion(' "$OUT"/smali* | grep -v "^$P" | head -60 || true
echo "----- every use of the stored statusBarView -----"
grep -rn -B2 -A4 --include='*.smali' 'statusBarView:' "$OUT"/smali* | head -80 || true
echo "----- callers of startRemoteAccessApp -----"
grep -rn --include='*.smali' 'startRemoteAccessApp(' "$OUT"/smali* | head -20 || true
