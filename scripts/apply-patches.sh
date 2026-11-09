#!/usr/bin/env bash
# Apply the two owner-approved edits to the decompiled 6.48 launcher.
#   1. lock-screen line  -> "This device is not private. It belongs to Sato Pharma."
#   2. status bar        -> stop disabling it + skip the overlay, so the pull-down shade and Android's
#                           "Privacy reminder" / "Location can be accessed" notices return.
set -euo pipefail
OUT="${1:?decompiled dir}"
VERSION_NAME="${2:?new version name}"
HERE="$(cd "$(dirname "$0")" && pwd)"

OLD_LINE='This device belongs to Sato Pharma'
NEW_LINE='This device is not private. It belongs to Sato Pharma.'

echo "== 1. lock-screen line =="
hits="$(grep -rl --include='*.smali' -F "$OLD_LINE" "$OUT"/smali* || true)"
if [ -z "$hits" ]; then echo "::error::lock-screen line not found — binary changed?"; exit 1; fi
echo "$hits" | while read -r f; do
  sed -i "s|${OLD_LINE}|${NEW_LINE}|g" "$f"
done
echo "$NEW_LINE" >/dev/null
grep -rn --include='*.smali' -F "$NEW_LINE" "$OUT"/smali* | head
if grep -rn --include='*.smali' -F "$OLD_LINE" "$OUT"/smali* ; then echo "::error::old lock-screen line still present"; exit 1; fi

echo "== 2. status bar (restore the pull-down + notices) =="
bash "$HERE/patch-statusbar.sh" "$OUT"

echo "== 3. version bump =="
python3 - "$OUT/apktool.yml" "$VERSION_NAME" <<'PY'
import sys,re
p,vname=sys.argv[1],sys.argv[2]
s=open(p,encoding='utf-8').read()
m=re.search(r'versionCode:\s*[\'"]?(\d+)',s)
code=int(m.group(1)) if m else 0
newcode=code+1
s=re.sub(r"(versionCode:\s*)['\"]?\d+['\"]?", r"\1'%d'"%newcode, s, count=1)
s=re.sub(r"(versionName:\s*)['\"]?[^\n'\"]+['\"]?", r"\1'%s'"%vname, s, count=1)
open(p,'w',encoding='utf-8').write(s)
print("versionCode %d -> %d, versionName -> %s"%(code,newcode,vname))
PY
echo "patches applied."
