extends RigidBody2D

var pickme = true
var defMode

func _ready():
	var a = RigidBody2D.MODE_CHARACTER
	set_mode(a)
	defMode = a
	pass