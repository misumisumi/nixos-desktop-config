"""layout and group"""
from libqtile import layout
from libqtile.config import Group, Match

from my_modules.my_layouts import layout1, layout2, layout3, layout4
from my_modules.param import PARAM

from libqtile.log_utils import logger

_match_code = [Match(wm_class='code')]

_match_browse = [Match(wm_class='vivaldi-stable'),
                Match(wm_class='firefox')
               ]
_match_paper = [Match(wm_class='org.pwmt.zathura')]

_match_analyze = [Match(title='WaveSurfer 1.8.8p5'),
                 Match(wm_class='thunar'),
                ]

_match_full = [Match(wm_class='Steam'),
               Match(wm_class='lutris'),
               Match(wm_class='resolve'),
               Match(wm_class='krita'),
               Match(wm_class='Gimp'),
               Match(wm_class='Blender'),
               Match(wm_class='unityhub'),
               Match(wm_class='Unity'),
               Match(wm_class='obs'),
               Match(wm_class='audacity'),
               Match(wm_class='Looking Glass (client)')
             ]

_match_sns = [Match(wm_class='slack'),
             Match(wm_class='discord'),
             Match(wm_class='zoom')]

_match_media = [Match(wm_class='pavucontrol'),
                Match(wm_class='blueman-manager')
              ]

_group_and_rule = {'code': ('', (layout2, layout3), _match_code),
                   'browse': ('', (layout1,), _match_browse),
                   'paper': ('', (layout1,), _match_paper),
                   'analyze': ('ﲋ', (layout1,), _match_analyze),
                   'full': ('', (layout4,), _match_full),
                   'sns': ('', (layout1,), _match_sns),
                   'media': ('', (layout2, layout3), _match_media)}

_display_tablet = {'creation': ('', layout4, _match_full)}

GROUP_PER_SCREEN = len(_group_and_rule)

def _set_groups():
    groups = []

    for n in range(PARAM.num_screen):
        for k, (label, layouts, matches) in _group_and_rule.items():
            if n == 1 and len(layouts) > 1:
                layouts = layouts[1]
            else:
                layouts = layouts[0]
            groups.append(Group('{}-{}'.format(n, k), layouts=layouts, matches=matches, label=label))
    if PARAM.is_display_tablet:
        name = list(_display_tablet.keys())[0]
        groups.append(Group('{}'.format(name), layouts=_display_tablet[name][1], matches=_display_tablet[name][2], label=_display_tablet[name][0]))
    
    return groups

groups = _set_groups()
