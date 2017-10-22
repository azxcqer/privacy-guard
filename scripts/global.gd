extends Control

var os = OS.get_name()
var size = OS.get_window_size()
var resize = 3
var justChangedLevel = false

# save vars
# init the file
var savegame = File.new()
# save path
var save_path = "user://savegame.save"
var progress = 0

func reload():
	get_tree().reload_current_scene()

func next(a):
	print("changing level! to " + str(a))
	get_tree().change_scene(a)

# create save function
func create_save():
	print("creating save")
	savegame.open(save_path, File.WRITE)
	savegame.close()
	save_progress()

	print(savegame)

func save_progress():
	if savegame != null:
		savegame.open(save_path, File.WRITE)
		savegame.store_var(progress)
		savegame.close()
		print("progress saved " + str(progress) + "!")

func load_progress():
		savegame.open(save_path, File.READ) #open the file
		progress = savegame.get_var() #get the value
		savegame.close()
		print("saved: " + str(progress))


func _ready():
	get_big()
	set_process_input(true)
	randomize()

	# save things
	if !savegame.file_exists(save_path):
		create_save()
	else:
		load_progress()

func get_big():
	if os != "Html5":
		OS.set_window_size(resize * size)

func _input(event):
	if event.is_action_pressed("ui_quit"):
		save_progress()
		get_tree().quit()
	if event.is_action_pressed("ui_restart"):
		reload()

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_QUIT_REQUEST:
		save_progress()
