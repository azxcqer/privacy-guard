extends RigidBody2D

# move vars
export var dir = -1
var autoMoves = true
var speed = 40
var jumpHeight = -100
var jump = false
# should I auto jump?
var jumper = true
onready var ray = get_node("feet")

func _ready():
	ray.add_exception(self)
	set_fixed_process(true)
	set_process(true)
	
func die():
	queue_free()
	
func jump():
	set_axis_velocity(Vector2(0,jumpHeight))
	jump = false
	
func _process(delta):
	var a = ray.is_colliding()
	if a && get_linear_velocity().y <= 0 && jumper:
		jump = true

func _fixed_process(delta):
	# keep me straight as not to fuck everything up
	set_rot(0)
	# if I can jump them I will
	if jump:
		jump()
	# if I can move so I will
	if dir != 0:
		set_axis_velocity(Vector2(speed * dir, 0))

	if autoMoves:
		pass