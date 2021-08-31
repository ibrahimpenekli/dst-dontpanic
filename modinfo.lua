name = "Don't Panic"
description = [[Alerts players by text against season boss and hound/worm attacks.

Only players near the target player will hear the warning sound from Deerclops and Bearger. So, this mod makes your life easier if you play with a friend next to you has speakers muted.

Supported monsters:
- Deerclops
- Bearger
- Hounds or worms

Options:
- Off: Disables announcement
- Default: Alerts only if monster is growling
- In a day: Alerts both before a day and when monster is growling

On GitHub: https://github.com/ibrahimpenekli/dst-dontpanic
]]
author = "H.Ibrahim Penekli (ibrahimpenekli)"
version = "1.0.0"

api_version = 10
api_version_dst = 10

all_clients_require_mod = false
client_only_mod = false
dst_compatible = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

configuration_options =
{
    {
		name = "OPTION_DEERCLOPS_WARNING",
		label = "Deerclops",
		options =
		{
			{description = "Off", data = -1},
			{description = "Default", data = 0},
			{description = "In a Day", data = 1},
		},
		default = 0,
	},
    {
		name = "OPTION_BEARGER_WARNING",
		label = "Bearger",
		options =
		{
			{description = "Off", data = -1},
			{description = "Default", data = 0},
			{description = "In a Day", data = 1},
		},
		default = 0,
	},
    {
		name = "OPTION_HOUNDS_WARNING",
		label = "Hounds",
		options =
		{
			{description = "Off", data = -1},
			{description = "Default", data = 0},
			{description = "In a Day", data = 1},
		},
		default = 0,
	},
}
