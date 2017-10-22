extends "res://scripts/pickup.gd"

onready var zone = get_node("Area2D")
export var nextLevel = ""

func _ready():
	zone.connect("area_enter", self, "collides")

func die():
	global.reload()

func collides(thing):
	var a = thing.get_parent()
	print(a)
	if "isBad" in a:
		destroy()
	if "isTerminal" in a:
		if a.isTerminal:
			print("sucess!")
			print(nextLevel)
			global.next(nextLevel)