<?php

declare(strict_types=1);

use B13\Container\Tca\ContainerConfiguration;
use B13\Container\Tca\Registry;
use TYPO3\CMS\Core\Utility\ExtensionManagementUtility;
use TYPO3\CMS\Core\Utility\GeneralUtility;

defined('TYPO3') or die();

ExtensionManagementUtility::addTcaSelectItem(
    'tt_content',
    'CType',
    [
        'label' => 'LLL:EXT:c4theme/Resources/Private/Language/locallang_db.xlf:wizard.cr_itemdetail',
        'value' => 'cr_itemdetail',
        'icon' => 'cr_itemdetail',
        'group' => 'default',
    ],
    'header',
    'after',
);

ExtensionManagementUtility::addTcaSelectItem(
    'tt_content',
    'CType',
    [
        'label' => 'LLL:EXT:c4theme/Resources/Private/Language/locallang_db.xlf:wizard.cr_logobanner',
        'value' => 'cr_logobanner',
        'icon' => 'cr_logobanner',
        'group' => 'default',
    ],
    'header',
    'after',
);

ExtensionManagementUtility::addTcaSelectItem(
    'tt_content',
    'CType',
    [
        'label' => 'LLL:EXT:c4theme/Resources/Private/Language/locallang_db.xlf:wizard.cr_banner',
        'value' => 'cr_banner',
        'icon' => 'cr_banner',
        'group' => 'default',
    ],
    'header',
    'after',
);

$GLOBALS['TCA']['tt_content']['types']['cr_itemdetail'] = [
    'showitem' => '
        --div--;LLL:EXT:core/Resources/Private/Language/Form/locallang_tabs.xlf:general,
            --palette--;;general,header,image,bodytext,
        --div--;LLL:EXT:core/Resources/Private/Language/Form/locallang_tabs.xlf:language,
            --palette--;;language,
        --div--;LLL:EXT:core/Resources/Private/Language/Form/locallang_tabs.xlf:access,
            --palette--;;hidden,
            --palette--;;access,
        --div--;LLL:EXT:core/Resources/Private/Language/Form/locallang_tabs.xlf:extended,
    ',
    'columnsOverrides' => [
        'bodytext' => [
            'config' => [
                'enableRichtext' => true,
                'richtextConfiguration' => 'default',
            ],
        ],
        'image' => [
            'config' => [
                'maxitems' => 1,
                'allowed' => 'jpeg,jpg,png',
                'overrideChildTca' => [
                    'columns' => [
                        'uid_local' => [
                            'config' => [
                                'appearance' => [
                                    'elementBrowserAllowed' => 'jpeg,jpg,png',
                                ],
                            ],
                        ],
                    ],
                ],
            ],
        ],
    ],
];

$GLOBALS['TCA']['tt_content']['types']['cr_logobanner'] = [
    'showitem' => '
        --div--;LLL:EXT:core/Resources/Private/Language/Form/locallang_tabs.xlf:general,
            --palette--;;general,header,bodytext,image,
        --div--;LLL:EXT:core/Resources/Private/Language/Form/locallang_tabs.xlf:language,
            --palette--;;language,
        --div--;LLL:EXT:core/Resources/Private/Language/Form/locallang_tabs.xlf:access,
            --palette--;;hidden,
            --palette--;;access,
        --div--;LLL:EXT:core/Resources/Private/Language/Form/locallang_tabs.xlf:extended,
    ',
    'columnsOverrides' => [
        'bodytext' => [
            'config' => [
                'enableRichtext' => true,
                'richtextConfiguration' => 'default',
            ],
        ],
        'image' => [
            'config' => [
                'maxitems' => 1,
                'overrideChildTca' => [
                    'columns' => [
                        'uid_local' => [
                            'config' => [
                                'appearance' => [
                                    'elementBrowserAllowed' => 'jpeg,jpg,png,svg,gif',
                                ],
                            ],
                        ],
                    ],
                ],
            ],
        ],
    ],
];

$GLOBALS['TCA']['tt_content']['types']['cr_banner'] = [
    'showitem' => '
        --div--;LLL:EXT:core/Resources/Private/Language/Form/locallang_tabs.xlf:general,
            --palette--;;general,image,
        --div--;LLL:EXT:core/Resources/Private/Language/Form/locallang_tabs.xlf:language,
            --palette--;;language,
        --div--;LLL:EXT:core/Resources/Private/Language/Form/locallang_tabs.xlf:access,
            --palette--;;hidden,
            --palette--;;access,
        --div--;LLL:EXT:core/Resources/Private/Language/Form/locallang_tabs.xlf:extended,
    ',
];

//
// Container elements (b13/container)
//
GeneralUtility::makeInstance(Registry::class)->configureContainer(
    (new ContainerConfiguration(
        'c4theme_2col',
        '2 Spalten',
        'Container mit 2 gleich breiten Spalten',
        [
            [
                ['name' => 'Links', 'colPos' => 201],
                ['name' => 'Rechts', 'colPos' => 202],
            ],
        ]
    ))->setIcon('EXT:c4theme/Resources/Public/Icons/Containers/2column.svg')
);

GeneralUtility::makeInstance(Registry::class)->configureContainer(
    (new ContainerConfiguration(
        'c4theme_3col',
        '3 Spalten',
        'Container mit 3 gleich breiten Spalten',
        [
            [
                ['name' => 'Spalte 1', 'colPos' => 301],
                ['name' => 'Spalte 2', 'colPos' => 302],
                ['name' => 'Spalte 3', 'colPos' => 303],
            ],
        ]
    ))->setIcon('EXT:c4theme/Resources/Public/Icons/Containers/3column.svg')
);

GeneralUtility::makeInstance(Registry::class)->configureContainer(
    (new ContainerConfiguration(
        'c4theme_4col',
        '4 Spalten',
        'Container mit 4 gleich breiten Spalten',
        [
            [
                ['name' => 'Spalte 1', 'colPos' => 401],
                ['name' => 'Spalte 2', 'colPos' => 402],
                ['name' => 'Spalte 3', 'colPos' => 403],
                ['name' => 'Spalte 4', 'colPos' => 404],
            ],
        ]
    ))->setIcon('EXT:c4theme/Resources/Public/Icons/Containers/4column.svg')
);
