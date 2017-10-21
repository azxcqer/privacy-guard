extends Node2D

var sprite_verde = load('res://assets/generic tile verde teste.png')
var arrow_v = load('res://assets/plain-arrow_v.png')
var arrow_h = load('res://assets/plain-arrow_h.png')

var is_empty = false
var destination = false

var direction = Vector2()

func set_empty():
	is_empty = true
	get_node("sprite").hide()

func set_destination():
	destination = true
	get_node("sprite").set_texture(sprite_verde)

func set_direction(x, y):
	var arrow = get_node("arrow")
	direction = Vector2(x, y)
	
	if direction.x < 0:
		arrow.show()
		arrow.set_texture(arrow_h)
		arrow.set_flip_h(true)
	if direction.x > 0:
		arrow.show()
		arrow.set_texture(arrow_h)
		arrow.set_flip_h(false)
	
	if direction.y < 0:
		arrow.show()
		arrow.set_texture(arrow_v)
		arrow.set_flip_h(false)
	if direction.y > 0:
		arrow.show()
		arrow.set_texture(arrow_v)
		arrow.set_flip_h(true)