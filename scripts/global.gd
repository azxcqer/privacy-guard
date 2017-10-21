extends Control

var os = OS.get_name()
var size = OS.get_window_size()
var resize = 3

func _ready():
	get_big()
	set_process_input(true)

func get_big():
	if os != "Html5":
		OS.set_window_size(resize * size)

func _input(event):
	if event.type == InputEvent.KEY:
		if Input.is_key_pressed(KEY_ESCAPE):
			get_tree().quit()