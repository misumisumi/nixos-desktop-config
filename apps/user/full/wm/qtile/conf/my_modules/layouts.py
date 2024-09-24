"""layout"""

from libqtile import layout
from libqtile.config import Match
from libqtile.log_utils import logger

from my_modules.colorset import ColorSet
from my_modules.variables import FontConfig, WindowConf

_settings = {
    "border_width": WindowConf.border,
    "border_focus": ColorSet.cyan,
    "border_normal": ColorSet.background,
}

_floating_settings = {
    "border_width": WindowConf.border,
    "border_focus": ColorSet.cyan,
    "border_normal": ColorSet.background,
}
# for default
layout1 = [
    layout.Columns(
        **_settings,
        border_focus_stack=ColorSet.cyan,
        border_normal_stack=ColorSet.background,
        border_on_single=True,
        fair=False,
        num_columns=2,
        insert_position=1,
        margin=WindowConf.margin,
        margin_on_single=WindowConf.margin,
        split=False,
    ),
]
# For code
layout2 = [
    layout.MonadTall(
        **_settings,
        align=layout.MonadTall._right,
        ratio=0.65,
        new_client_position="after_current",
        single_border_width=WindowConf.border,
        margin=WindowConf.margin,
        single_margin=WindowConf.margin,
    ),
    layout.Columns(
        **_settings,
        border_focus_stack=ColorSet.cyan,
        border_normal_stack=ColorSet.background,
        border_on_single=True,
        fair=False,
        num_columns=2,
        insert_position=1,
        margin=WindowConf.margin,
        margin_on_single=WindowConf.margin,
        split=False,
    ),
]

layout3 = [
    layout.MonadTall(
        **_settings,
        align=layout.MonadTall._left,
        ratio=0.65,
        new_client_position="bottom",
        single_border_width=WindowConf.border,
        margin=WindowConf.margin,
        single_margin=WindowConf.margin,
    ),
    layout.Columns(
        **_settings,
        border_focus_stack=ColorSet.cyan,
        border_normal_stack=ColorSet.background,
        border_on_single=True,
        fair=False,
        num_columns=2,
        insert_position=1,
        margin=WindowConf.margin,
        margin_on_single=WindowConf.margin,
        split=False,
    ),
]
# For full
layout4 = [
    layout.TreeTab(
        active_bg=ColorSet.bblack,
        bg_color=ColorSet.background,
        font=FontConfig.font,
        sections=["WS{}".format(i) for i in range(1, 6)],
        level_shift=20,
        fontsize=FontConfig.fontsize,
        section_fontsize=FontConfig.fontsize,
    ),
]

floating_layout = layout.Floating(
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
