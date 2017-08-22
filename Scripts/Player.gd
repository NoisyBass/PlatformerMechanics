extends KinematicBody2D

var direction = 0
var last_direction = 0
var speed = 0
export var max_speed = 600
export var acceleration = 1000
export var deceleration = 2000
var velocity = Vector2(0, 0)

func _ready():
	set_process(true)
	pass
	
func _process(delta):
	if direction:
		last_direction = direction
	
	if Input.is_action_pressed("ui_left"):
		direction = -1
	elif Input.is_action_pressed("ui_right"):
		direction = 1
	else:
		direction = 0
		
	if direction == -last_direction:
		speed /= 3
	if direction:
		speed += acceleration * delta
	else:
		speed -= deceleration * delta
	speed = clamp(speed, 0, max_speed)
		
	velocity.x = speed * delta * last_direction
	move(velocity)
	pass
