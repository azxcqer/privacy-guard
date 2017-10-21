extends Node2D

var is_empty = false

func set_empty():
	is_empty = true
	get_node("sprite").hide()