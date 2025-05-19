# Steam CDN Diagnostic Toolkit (Helldivers 2 Crash Analysis)

This toolkit was created to debug and monitor Steam CDN resolution failures that cause missing asset loads in Helldivers 2. These failures result in `c0000005` crashes due to null pointer dereferences.

---

## Problem Summary

Helldivers 2 crashes at runtime when Steam CDN asset domains fail to resolve. This causes the game to dereference uninitialized data (null pointers) tied to missing textures, ships, or other downloadable content.

---

## Affected Domains

These domains resolve to no A records across all major public DNS resolvers:

- `steamcontent.com`
- `steamstatic.com`
- `steamusercontent.com`
- `akamaihd.net`
- `playfabapi.com`

---

## Tools Included

### `check_steam_domains.sh` (Bash)
Performs resolution, traceroute, and HTTPS check for affected domains.

```bash
chmod +x check_steam_domains.sh
./check_steam_domains.sh
```

### `nsLookupsSteam.ps1`
Performs the same checks as the shell script but in Powershell.

## Files Included

### `dbganalysis.txt`
WinDbg `!analyze -v` output with OS name info obfuscated.
