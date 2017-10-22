extends RigidBody2D

# move vars
export var dir = 1
var dirLast = dir
var autoMoves = true
var speed = 50
var jumpHeight = -95
var jump = false
# should I auto jump?
var jumper = true
var jumpAble = false
onready var ray = get_node("feet")

func _ready():
	ray.add_exception(self)
	set_fixed_process(true)
	set_process(true)
	change_direction()
	set_gravity_scale(1.5)
	
func die():
	queue_free()
	
func jump():
	if jumpAble:
		set_axis_velocity(Vector2(0,jumpHeight))
		jumpAble = false

func change_direction():
	if dir == 1:
		set_scale(Vector2(1,1))
	if dir == -1:
		set_scale(Vector2(-1,1))
	
func _process(delta):
	var a = ray.is_colliding()
	if a && get_linear_velocity().y <= 0:
		jumpAble = true
	
func _fixed_process(delta):
	# keep me straight as not to fuck everything up
	set_rot(0)
	# if I can jump them I will
	if jumper:
		jump()
	# if I can move so I will
	if dir != 0:
		set_axis_velocity(Vector2(speed * dir, 0))
	
	change_direction()

	if autoMoves:
		pass