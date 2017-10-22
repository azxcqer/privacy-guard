extends "res://scripts/moves.gd"

var pickme = true
var defMode

func _ready():
	defMode = get_mode()
	moves = false
	jumper = false