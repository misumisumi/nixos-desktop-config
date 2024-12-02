"""layout"""

from libqtile import layout
from libqtile.config import Match
from libqtile.log_utils import logger

from my_modules.colorset import ColorSet
from my_modules.variables import WindowConf

_settings = {
    "border_focus": ColorSet.accent,
    "border_normal": ColorSet.background,
    "border_width": WindowConf.border,
    "margin": WindowConf.margin,
}

_floating_settings = {
    "border_width": WindowConf.border,
    "border_focus": ColorSet.accent,
    "border_normal": ColorSet.background,
}
# for default
layout1 = [
    layout.Columns(
        **_settings,
        border_focus_stack=ColorSet.accent,
        border_normal_stack=ColorSet.background,
        border_on_single=True,
        fair=False,
        num_columns=2,
        insert_position=1,
        margin_on_single=WindowConf.margin,
        split=False,
        wrap_focus_columns=False,
        wrap_focus_row=False,
        wrap_focus_stacks=False,
    ),
    layout.Max(**_settings),
]
# For code
layout2 = [
    layout.MonadTall(
        **_settings,
        align=layout.MonadTall._right,
        ratio=0.65,
        new_client_position="after_current",
        single_border_width=WindowConf.border,
        single_margin=WindowConf.margin,
    ),
    layout.Max(**_settings),
]

# For full
layout3 = [
    layout.Max(
        margin=0,
        border_width=1,
        border_focus=ColorSet.accent,
        border_normal=ColorSet.background,
    ),
]


def set_floating_layout():
    return layout.Floating(
        float_rules=[
            # Run the utility of `xprop` to see the wm class and name of an X client.
            *layout.Floating.default_float_rules,  # アスペクト比固定のものでもタイリングさせる
            Match(wm_class="confirmreset"),  # gitk
            Match(wm_class="makebranch"),  # gitk
            Match(wm_class="maketag"),  # gitk
            Match(wm_class="ssh-askpass"),  # ssh-askpass
            Match(wm_class="pentablet"),
            Match(title="branchdialog"),  # gitk
            Match(title="pinentry"),  # GPG key password entry
        ],
        **_floating_settings,
    )


def set_layouts():
    return layout1 + layout2 + layout3
