# Phoenix rep-tablet launcher — patch build

The launcher's source is gone (the old fork's GitHub account is suspended). The only surviving carrier
of the Phoenix changes is the compiled app, kept here as release assets (`launcher-6.48-r1`, etc.).

`.github/workflows/patch-launcher.yml` rebuilds a new signed app by patching that proven binary:
- **inspect** — decompiles 6.48 and prints/uploads the smali of the two edit targets.
- **build** — applies the lock-screen line + the pull-down (status bar) edit, re-signs with the Phoenix
  key from repo secrets, and publishes a signed release.

Signing secrets (added by the owner, never by the tool): `SIGNING_KEYSTORE_B64`,
`SIGNING_KEYSTORE_PASSWORD`, `SIGNING_KEY_ALIAS`, `SIGNING_KEY_PASSWORD`.
