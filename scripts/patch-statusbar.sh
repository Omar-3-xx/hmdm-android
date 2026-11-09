#!/usr/bin/env bash
# Restore the pull-down + Android's notices on the rep tablets, by two surgical smali edits:
#   B. Utils.setStatusBarDisabled  -> force the DevicePolicyManager argument to false, so the launcher
#      can never disable the real system status bar / shade.
#   C. Initializer                 -> skip starting StatusBarOverlayService, the overlay that drew the
#      clean bar over Android's real one (which hid the notices and blocked the swipe).
set -euo pipefail
OUT="${1:?decompiled dir}"
U="$OUT/smali/com/hmdm/launcher/util/Utils.smali"
I="$OUT/smali/com/hmdm/launcher/helper/Initializer.smali"
[ -f "$U" ] || { echo "::error::Utils.smali not found at $U"; exit 1; }
[ -f "$I" ] || { echo "::error::Initializer.smali not found at $I"; exit 1; }

# ---- Edit B: force setStatusBarDisabled(...false) ------------------------------------------------
ANCHOR_B='invoke-virtual {v0, p0, p1}, Landroid/app/admin/DevicePolicyManager;->setStatusBarDisabled(Landroid/content/ComponentName;Z)Z'
countB=$(grep -cF "$ANCHOR_B" "$U" || true)
if [ "$countB" != "1" ]; then echo "::error::expected exactly 1 setStatusBarDisabled call in Utils, found $countB"; exit 1; fi
if grep -qF 'const/4 p1, 0x0' "$U"; then echo "edit B already present"; else
  # insert "const/4 p1, 0x0" on the line before the anchor
  awk -v a="$ANCHOR_B" '
    index($0,a){ print "    const/4 p1, 0x0"; print "" }
    { print }
  ' "$U" > "$U.tmp" && mv "$U.tmp" "$U"
fi
grep -nF 'const/4 p1, 0x0' "$U" | head
echo "edit B done"

# ---- Edit C: skip the overlay start --------------------------------------------------------------
ANCHOR_C='invoke-static {p0, v4}, Lcom/hmdm/launcher/util/Utils;->setStatusBarDisabled(Landroid/content/Context;Z)V'
countC=$(grep -cF "$ANCHOR_C" "$I" || true)
if [ "$countC" != "1" ]; then echo "::error::expected exactly 1 setStatusBarDisabled call-site in Initializer, found $countC"; exit 1; fi
# confirm the skip target label exists
if ! grep -qE '^\s*:goto_6\s*$' "$I" && ! grep -qE 'goto :goto_6' "$I"; then echo "::error:::goto_6 label not found in Initializer"; exit 1; fi
if grep -qF 'goto :goto_6  # phoenix-skip-overlay' "$I"; then echo "edit C already present"; else
  awk -v a="$ANCHOR_C" '
    { print }
    index($0,a){ print ""; print "    goto :goto_6  # phoenix-skip-overlay" }
  ' "$I" > "$I.tmp" && mv "$I.tmp" "$I"
fi
grep -nF 'phoenix-skip-overlay' "$I" | head
echo "edit C done"
