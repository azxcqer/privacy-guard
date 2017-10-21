extends Control

const GAME_DATA_FILE = "game_data.txt"
var os = OS.get_name()
var size = OS.get_window_size()
var resize = 3
var game_data = {current_level = 0}

func _ready():
	get_big()
	set_process_input(true)
	#retrieves game data
	var file = File.new()
	if file.open(GAME_DATA_FILE, File.READ) != 0:
		print("Erro ao abrir o arquivo")
	else:
		var json = file.get_as_text()
		file.close()
		game_data.parse_json(json)

func get_big():
	if os != "Html5":
		OS.set_window_size(resize * size)

func _input(event):
	if event.type == InputEvent.KEY:
		if Input.is_key_pressed(KEY_ESCAPE):
			get_tree().quit()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		var file = File.new()
		if file.open(GAME_DATA_FILE, File.WRITE) == 0:
			file.store_line(game_data.to_json())
			file.close()
		get_tree().quit()