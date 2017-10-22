extends "res://scripts/moves.gd"

onready var pickupPoint = get_node("pickup")
var pickedUp = false
var pickTarget = ""
var targeted = ""

onready var pickupArea = get_node("pickup/Area2D")
onready var camera = get_node("Camera2D")

func _ready():
	set_process_input(true)
	dir = 0
	jump = false
	dir = 0
	jumper = false
	
	# camera.make_current()
	
	pickupArea.connect("body_enter", self, "youre_here")
	pickupArea.connect("body_exit", self, "cya")

func die():
	global.reload()
	
func youre_here(thing):
	targeted = thing
	print(thing)

func cya(a):
	targeted = ""

func pickup():
	if pickedUp:
		release(pickTarget)
		pickedUp = false
	else:
		if targeted != null:
			if "pickme" in targeted:
				grab(targeted)
				pickedUp = true
				
func grab(thing):
	var a = pickupPoint.get_global_pos()
	print("grabby!")
	pickTarget = thing
	thing.get_parent().remove_child(thing) 
	pickupPoint.add_child(thing)
	thing.set_global_pos(a)
	thing.set_mode(RigidBody2D.MODE_STATIC)

func release(thing):
	var a = pickupPoint.get_global_pos()
	thing.get_parent().remove_child(thing)
	get_parent().add_child(thing)
	thing.set_global_pos(a)
	print("release!")
	thing.set_mode(thing.defMode)

func _process(delta):
	if jump && jumpAble:
		jump()

func _input(event):
	jump = Input.is_action_pressed("ui_up")
	dir = (Input.is_action_pressed("ui_left")) * -1 + Input.is_action_pressed("ui_right")
	if Input.is_action_pressed("ui_select"):
		pickup()	