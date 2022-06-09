from libqtile import widget
from .theme import colors

# Get the icons at https://www.nerdfonts.com/cheat-sheet (you need a Nerd Font)


def base(fg="text", bg="dark"):
    return {"foreground": colors[fg], "background": colors[bg]}


def separator():
    return widget.Sep(**base(), linewidth=0, padding=3)


def spacer():
    return widget.Spacer(**base(), linewidth=0, padding=3)


def icon(fg="text", bg="dark", fontsize=15, text="?"):
    return widget.TextBox(**base(fg, bg), fontsize=fontsize, text=text, padding=2)


def powerline(fg="light", bg="dark"):
    return widget.TextBox(
        **base(fg, bg), text="", fontsize=35, padding=-4  # Icon: nf-oct-triangle_left
    )


def workspaces():
    return [
        separator(),
        widget.GroupBox(
            **base(fg="light"),
            font="mononoki Nerd Font",
            fontsize=22,
            margin_y=3,
            margin_x=0,
            padding_y=8,
            padding_x=5,
            borderwidth=1,
            active=colors["active"],
            inactive=colors["inactive"],
            rounded=False,
            highlight_method="block",
            urgent_alert_method="block",
            urgent_border=colors["urgent"],
            this_current_screen_border=colors["focus"],
            this_screen_border=colors["grey"],
            other_current_screen_border=colors["dark"],
            other_screen_border=colors["dark"],
            disable_drag=True
        ),
        separator(),
        widget.WindowName(**base(fg="light"), fontsize=15, padding=3),
        separator(),
    ]


primary_widgets = [
    widget.Image(filename="~/.config/qtile/images/manjaro-logo.png"),
    *workspaces(),
    separator(),
    powerline("grey", "dark"),
    widget.Systray(background=colors["grey"], padding=2),
    powerline("color5", "grey"),
    icon(bg="color5", fg="light", text="🖬"),
    widget.Memory(
        **base(fg="light", bg="color5"), format="{MemUsed: .0f} MB ", padding=3
    ),
    powerline("color4", "color5"),
    icon(bg="color4", text=" "),  # Icon: nf-fa-download
    widget.CheckUpdates(
        background=colors["color4"],
        colour_have_updates=colors["text"],
        colour_no_updates=colors["text"],
        no_update_string="0",
        display_format="{updates}",
        update_interval=1800,
        custom_command="checkupdates",
    ),
    powerline("color3", "color4"),
    icon(bg="color3", text=""),  # Icon: nf-fa-feed
    widget.Net(**base(bg="color3"), interface="wlo1", format="↓{down}"),
    powerline("color2", "color3"),
    widget.CurrentLayoutIcon(**base(bg="color2"), scale=0.65),
    widget.CurrentLayout(**base(bg="color2"), padding=5),
    powerline("color3", "color2"),
    icon(bg="color3", fontsize=17, text=" "),  # Icon: nf-mdi-calendar_clock
    widget.Clock(**base(bg="color3"), format="%I:%M %d/%m"),
    powerline("dark", "color3"),
    separator(),
]

secondary_widgets = [
    *workspaces(),
    separator(),
    powerline("color1", "dark"),
    widget.CurrentLayoutIcon(**base(bg="color1"), scale=0.65),
    widget.CurrentLayout(**base(bg="color1"), padding=5),
    powerline("color3", "color1"),
    widget.Clock(**base(bg="color3"), format="%d/%m/%Y - %H:%M  "),
    powerline("dark", "color2"),
]

left_widgets = [
    spacer(),
    widget.CPU(**base(bg="color2")),
    separator(),
    widget.Moc(**base(bg="color4")),
    separator(),
    widget.Clock(**base(bg="color3"), format="%H:%M"),
    separator(),
]

widget_defaults = {
    "font": "mononoki Nerd Font Bold",
    "fontsize": 13,
    "padding": 1,
}
extension_defaults = widget_defaults.copy()
