<?php

(static function (array $from, array $allowedVariables) {
    /**
     * Parse environment variables into PHP global variables. Any '__' in a key will be interpreted as 'next array level'.
     * An example would be: TYPO3_CONF_VARS__DB__Connections__Default__dbname=some_db
     *
     * Conversions in keys:
     *   '_bs_' -> '\'
     * Conversions in values:
     *   Numeric values -> integer
     *   'bool(false)' => false
     *   'bool(true)' => true
     *   'array()' => []
     * @param array<string,string> $from the array which shall be watched for keys that are matching $allowedVariables
     * @param string[] $allowedVariables the names of variables in $GLOBALS that shall be imported
     */
    foreach ($from as $k => $v) {
        $keyArr = explode('__', $k);
        if (in_array($variable = array_shift($keyArr), $allowedVariables)) {
            $finalKey = array_pop($keyArr);
            $finalKey = str_replace('_bs_', '\\', $finalKey);
            for ($level = &$GLOBALS[$variable]; $nextLevel = array_shift($keyArr);) {
                $nextLevel = str_replace('_bs_', '\\', $nextLevel);
                if (!isset($level[$nextLevel])) {
                    $level[$nextLevel] = [];
                }
                $level = &$level[$nextLevel];
            }
            if ($v === 'bool(false)') {
                $v = false;
            } elseif ($v === 'bool(true)') {
                $v = true;
            } elseif ($v === 'array()') {
                $v = [];
            } elseif (is_numeric($v)) {
                $v = (int)$v;
            }

            $level[$finalKey] = $v;
        }
    }
})(
    $_SERVER,
    ['TYPO3_CONF_VARS']
);

// File-Browser: Bildgrößen anzeigen (TYPO3 v13)
$GLOBALS['TYPO3_CONF_VARS']['BE']['fileList']['displayFields'] = [
    'size',
    'dimensions',
    'tstamp'
];

// GPX, GDB und KML Dateien erlauben - über SYS['mediafile_ext'] und GFX['imagefile_ext']
// Diese Konfiguration wird nicht überschrieben, da sie in additional.php gesetzt wird
if (isset($GLOBALS['TYPO3_CONF_VARS']['SYS']['mediafile_ext'])) {
    $currentMediaExtensions = $GLOBALS['TYPO3_CONF_VARS']['SYS']['mediafile_ext'];
} else {
    // Fallback: Standard-Erweiterungen
    $currentMediaExtensions = 'gif,jpg,jpeg,bmp,png,webp,pdf,svg,ai,mp3,wav,mp4,ogg,flac,opus,webm,youtube,vimeo';
}

$allowedMediaExtensions = array_map('trim', explode(',', $currentMediaExtensions));
$newExtensions = ['kml', 'gpx', 'gdb'];
foreach ($newExtensions as $ext) {
    if (!in_array($ext, $allowedMediaExtensions, true)) {
        $allowedMediaExtensions[] = $ext;
    }
}
$GLOBALS['TYPO3_CONF_VARS']['SYS']['mediafile_ext'] = implode(',', array_filter($allowedMediaExtensions));

// Deutsche Übersetzungen für bootstrap_package (Pagination)
$GLOBALS['TYPO3_CONF_VARS']['SYS']['locallangXMLOverride']['de']['EXT:bootstrap_package/Resources/Private/Language/locallang.xlf'][] = 'EXT:c4theme/Resources/Private/Language/de.bootstrap_package.locallang.xlf';

// GFX['imagefile_ext'] - für Bildverarbeitung
if (isset($GLOBALS['TYPO3_CONF_VARS']['GFX']['imagefile_ext'])) {
    $currentImageExtensions = $GLOBALS['TYPO3_CONF_VARS']['GFX']['imagefile_ext'];
} else {
    // Fallback: Standard-Erweiterungen
    $currentImageExtensions = 'gif,jpg,jpeg,tif,tiff,bmp,pcx,tga,png,pdf,ai,svg,webp,avif';
}

$allowedImageExtensions = array_map('trim', explode(',', $currentImageExtensions));
foreach ($newExtensions as $ext) {
    if (!in_array($ext, $allowedImageExtensions, true)) {
        $allowedImageExtensions[] = $ext;
    }
}
$GLOBALS['TYPO3_CONF_VARS']['GFX']['imagefile_ext'] = implode(',', array_filter($allowedImageExtensions));
