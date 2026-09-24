#!/bin/bash
# Inhaltskorrekturen auf Live einspielen: DB-Backup → SQL → Cache leeren → Kontrolle
# Aufruf aus dem Projektordner:  scripts/inhalte/live-einspielen.sh scripts/inhalte/2026-09-24-korrekturen.sql
set -euo pipefail
sql="${1:?Pfad zur SQL-Datei angeben}"
name=$(basename "$sql")

rsync -az "$sql" vogler:backup/"$name"
ssh vogler 'set -e
cd ~/typo3_14
set -a; . ./.env.live; set +a
export MYSQL_PWD=$TYPO3_CONF_VARS__DB__Connections__Default__password
o="-h $TYPO3_CONF_VARS__DB__Connections__Default__host -u $TYPO3_CONF_VARS__DB__Connections__Default__user"
db=$TYPO3_CONF_VARS__DB__Connections__Default__dbname
f=~/backup/${db}_vor-'"${name%.sql}"'_$(date +%Y%m%d_%H%M%S).sql.gz
mysqldump $o --single-transaction --no-tablespaces $db | gzip -9 > $f
echo "Backup: $f ($(zcat $f | tail -1))"
mysql $o $db < ~/backup/'"$name"'
/usr/bin/php83 vendor/bin/typo3 cache:flush
echo "Eingespielt: '"$name"'"'

curl -s https://www.vogler-bau-gmbh.de/ | grep -oE 'mailto:[^"]*|vb-map__load|§ 5 [A-Z]+' | sort -u
curl -s https://www.vogler-bau-gmbh.de/impressum | grep -oE '§ 5 [A-Z]+' | sort -u
