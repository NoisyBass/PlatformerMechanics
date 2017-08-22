extends KinematicBody2D

var direction = 0
var last_direction = 0

var speed_x = 0
var speed_y = 0

export var max_speed = 600
export var acceleration = 1000
export var deceleration = 2000
var velocity = Vector2(0, 0)

export var jump_force = 800
export var gravity = 2000

func _ready():
	set_process(true)
	set_process_input(true)
	
func _input(event):
	if event.is_action_pressed("jump"):
		speed_y = -jump_force
	
func _process(delta):
	if direction:
		last_direction = direction
	
	if Input.is_action_pressed("move_left"):
		direction = -1
	elif Input.is_action_pressed("move_right"):
		direction = 1
	else:
		direction = 0
		
	if direction == -last_direction:
		speed_x /= 3
	if direction:
		speed_x += acceleration * delta
	else:
		speed_x -= deceleration * delta
	speed_x = clamp(speed_x, 0, max_speed)
	
	speed_y += gravity * delta
		
	velocity.x = speed_x * delta * last_direction
	velocity.y = speed_y * delta
	move(velocity)
