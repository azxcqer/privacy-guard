extends Control

var os = OS.get_name()
var size = OS.get_window_size()
var resize = 3

func _ready():
	get_big()

func get_big():
	if os != "Html5":
		OS.set_window_size(resize * size)