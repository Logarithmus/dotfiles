#!/bin/sh
dark_theme="gruvbox_dark"
light_theme="gruvbox_light"
cd ${XDG_CONFIG_HOME}/kitty/
case "$(readlink theme.conf)" in
	themes/${dark_theme}.conf)
		ln -sf "themes/${light_theme}.conf" theme.conf
		;;
	themes/${light_theme}.conf)
		ln -sf "themes/${dark_theme}.conf" theme.conf
		;;
esac
