-- This information tells other players more about the mod
name = "Don't Panic"
description = "Warns you for boss spawn as text!"
author = "H.Ibrahim Penekli"
version = "1.0.0"

all_clients_require_mod = false
client_only_mod = false
dst_compatible = true

icon_atlas = "modicon.xml"
icon = "modicon.tex"

configuration_options = 
{
    {
		name = "OPTION_DEERCLOPS_ENABLED",
		label = "Deerclops",
		options =	{
                        {description = "Off", data = false},
						{description = "On", data = true},
						
					},
		default = true,
	},
    {
		name = "OPTION_BEARGER_ENABLED",
		label = "Bearger",
		options =	{
                        {description = "Off", data = false},
						{description = "On", data = true},
						
					},
		default = true,
	},
    {
		name = "OPTION_HOUNDS_ENABLED",
		label = "Hounds",
		options =	{
                        {description = "Off", data = false},
						{description = "On", data = true},
						
					},
		default = false,
	},
}