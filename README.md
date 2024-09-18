# FiveM-AimBot

This extension is compatible with the FiveGuard AntiCheat system. Visit [FiveGuard's Discord server](https://discord.gg/fiveguard).

## Overview

This script automatically processes incoming AimBot logs via a Discord bot. If a player accumulates more than two AimBot logs per connection, they are automatically kicked. This helps streamline admin tasks and manage potential cheaters more efficiently.

Special thanks to FiveGuard for enabling the creation of this script.

## Configuration

### Changes - `aimbotHTTPRoute.lua`

- **Line 44:** Configure the number of AimBot logs required to trigger a kick. It is recommended to set this value to more than 1, as AimBot logs may not always be 100% accurate.

### Changes - `app.js`

- **Line 13:** Update the `securitytoken` to prevent unauthorized POST events to your FiveM server.
- **Line 14:** Replace `"resourcename"` with the name of the resource containing `aimbotHTTPRoute.lua`.
- **Line 29:** Enter the Discord Channel ID where FiveGuard posts AimBot logs.
- **Line 70:** Provide your Discord Bot Token.


Note: Please don’t judge this project too harshly. I put it together in about 10 minutes, and it’s been sitting around for over a year. Also, yes, I was too lazy to create a config file. ^^
