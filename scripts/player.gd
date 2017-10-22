extends "res://scripts/moves.gd"

# control vars


func _ready():
	set_process_input(true)
	dir = 0
	jump = false
	dir = 0
	jumper = false

func _process(delta):
	if jump && jumpAble:
		jump()

func _input(event):
	jump = Input.is_action_pressed("ui_up")
	dir = (Input.is_action_pressed("ui_left")) * -1 + Input.is_action_pressed("ui_right")
	