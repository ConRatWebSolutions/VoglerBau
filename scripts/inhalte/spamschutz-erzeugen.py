#!/usr/bin/env python3
"""Erzeugt 2026-09-24-spamschutz.sql aus der Formular-Definition „kontakt“ (Stand vorher: .kontakt-vorher.raw,
Ausgabe von: ddev mysql -N -e "SELECT configuration FROM form_definition WHERE uid=1").

Hinweis: In Validator-Optionen kein "<" verwenden (das Form-Framework entfernt beim Laden alles ab
einem vermeintlichen HTML-Tag) – daher \x3c. Geschweifte Klammern und "/" ebenfalls vermeiden.
"""
import hashlib
import json
from pathlib import Path

here = Path(__file__).parent
raw = (here / '.kontakt-vorher.raw').read_text(encoding='utf-8').rstrip('\n')
orig = raw.encode().decode('unicode_escape').encode('latin-1').decode('utf-8')
cfg = json.loads(orig)
page = cfg['renderables'][0]['renderables']

# keine Links, kein BBCode, keine kyrillischen Zeichen (U+0400–U+04FF als Zeichenbereich)
NO_SPAM = r'~^(?![\s\S]*(?:https?:|www\.|\[url|\x3ca\s))(?![\s\S]*[Ѐ-ӿ])[\s\S]*$~iu'
MSG = 'Bitte geben Sie keine Links (http://, www.) und nur lateinische Schrift ein.'
for el in page:
    if el['identifier'] in ('text-1', 'text-3', 'textarea-1'):
        el['validators'] = [v for v in el.get('validators', []) if v.get('identifier') != 'RegularExpression']
        el['validators'].append({'identifier': 'RegularExpression', 'options': {'regularExpression': NO_SPAM}})
        el.setdefault('properties', {})['validationErrorMessages'] = [{'code': 1221565130, 'message': MSG}]

page[:] = [el for el in page if el['identifier'] != 'spamschutz']
page.append({
    'type': 'Hidden', 'identifier': 'spamschutz', 'label': 'Spamschutz', 'defaultValue': '',
    'validators': [{'identifier': 'NotEmpty'},
                   {'identifier': 'RegularExpression', 'options': {'regularExpression': r'~^vb-\d+$~'}}],
})

new = json.dumps(cfg, ensure_ascii=False)
esc = new.replace('\\', '\\\\').replace("'", "\\'")
(here / '2026-09-24-spamschutz.sql').write_text(f"""-- Spamschutz Kontaktformular (form_definition uid 1 „kontakt“), 2026-09-24 – erzeugt mit spamschutz-erzeugen.py
-- Wiederholbar. Setzt die komplette Definition; Ausgangsstand sha1 {hashlib.sha1(orig.encode()).hexdigest()}
-- Neu: verstecktes Feld „spamschutz“ (wird per JS nach >= 3 s gefüllt, siehe c4theme custom.js)
--      und Filter gegen Links/kyrillische Schrift in Name, Betreff, Nachricht.
UPDATE form_definition SET configuration = '{esc}', tstamp = UNIX_TIMESTAMP() WHERE uid = 1 AND identifier = 'kontakt';
""", encoding='utf-8')
print('ok')
