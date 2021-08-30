name = "Don't Panic"
description = "Warns you for boss spawn as text!"
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
		default = 1,
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
		default = 1,
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
