package main

import "barista.run/pango/icons"

func loadIcons() {
	nf := icons.NewProvider("nf")

	nf.Font("FiraCode Nerd Font")

	nf.Symbol("music", " ")
	nf.Symbol("music-box", " ")
	nf.Symbol("today", " ")

	nf.Symbol("tint", " ")

	nf.Symbol("sunset-up", "瀞 ")
	nf.Symbol("sunset-down", "漢 ")

	nf.Symbol("battery", " ")
	nf.Symbol("battery-10", " ")
	nf.Symbol("battery-20", " ")
	nf.Symbol("battery-30", " ")
	nf.Symbol("battery-40", " ")
	nf.Symbol("battery-50", " ")
	nf.Symbol("battery-60", " ")
	nf.Symbol("battery-70", " ")
	nf.Symbol("battery-80", " ")
	nf.Symbol("battery-90", " ")
	nf.Symbol("battery-charging", " ")
	nf.Symbol("battery-charging-20", " ")
	nf.Symbol("battery-charging-30", " ")
	nf.Symbol("battery-charging-40", " ")
	nf.Symbol("battery-charging-50", " ")
	nf.Symbol("battery-charging-60", " ")
	nf.Symbol("battery-charging-70", " ")
	nf.Symbol("battery-charging-80", " ")
	nf.Symbol("battery-charging-90", " ")
	nf.Symbol("battery-charging-100", " ")
	nf.Symbol("battery-outline", " ")

	nf.Symbol("ethernet", " ")
	nf.Symbol("wifi", "直 ")
	nf.Symbol("access-point", " ")

	nf.Symbol("volume-mute", " ")
	nf.Symbol("volume-off", " ")
	nf.Symbol("volume-up", " ")
	nf.Symbol("volume-down", " ")

	nf.Symbol("desktop-tower", " ")
	nf.Symbol("trending-up", "勤 ")

	nf.Symbol("memory", " ")
	nf.Symbol("swap-horizontal", "易 ")
	nf.Symbol("swap-vertical", "李 ")
	nf.Symbol("fan", " ")

	nf.Symbol("upload", " ")
	nf.Symbol("download", " ")

	nf.Symbol("home", " ")
	nf.Symbol("hdd", " ")

	nf.Symbol("chart-areaspline", " ")
	nf.Symbol("warning", " ")

	nf.Symbol("time", " ")
}
