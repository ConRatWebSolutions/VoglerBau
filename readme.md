# Vogler Bau GmbH – www.vogler-bau-gmbh.de

Doku und Zugänge: obsidian://open?vault=Vogler%20Bau

TYPO3 14.3 (Composer), PHP 8.3, Sitepackage `packages/c4theme`, dazu b13/container.

## Live

- SSH: `ssh vogler` (Alias in `~/.ssh/config`, Key-Login), Instanz `~/typo3_14`
- Shell-`php` ist 7.4 → `/usr/bin/php83 vendor/bin/typo3 …`
- DB-Zugang steht nur auf dem Server in `~/typo3_14/.env.live`
- `config/system/settings.php` (encryptionKey) ist nicht im Repo – bei neuem Clone vom Server holen

## Lokal (DDEV)

```bash
ddev start
ddev composer install
ddev dump-db-fast        # Live-DB holen und einspielen (liest Zugangsdaten auf dem Server)
ddev dump-files          # fileadmin vom Server holen
```

Lokal: https://vogler-bau.ddev.site (Hosts-Eintrag nötig: `sudo /opt/homebrew/bin/ddev-hostname vogler-bau.ddev.site 127.0.0.1`)

## Deploy

```bash
ddev check               # Probelauf, zeigt Unterschiede, ändert nichts
ddev deploy live         # Backup auf dem Server, dann config, packages, vendor, _assets, var/labels
```

fileadmin, var/ (außer labels) und `.htaccess` werden nicht deployt.
