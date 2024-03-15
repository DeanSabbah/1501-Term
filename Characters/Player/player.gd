extends CharacterBody2D

@export var speed = 400
@export var jump_timing = 0
const gravity = 10000
var reset_jump_timing = false

func get_input():
	var input_direction = Input.get_vector("left", "right", "up", "down")
	
	if input_direction == Vector2.ZERO and Input.is_action_just_released("right"):
		$AnimatedSprite2D.play("idle_right")

	elif input_direction == Vector2.ZERO and Input.is_action_just_released("left"):
		$AnimatedSprite2D.play("idle_left")

	elif input_direction.x == -1:
		$AnimatedSprite2D.play("walk_right")
	elif input_direction.x == 1:
		$AnimatedSprite2D.play("walk_left")
	
		
	velocity = input_direction * speed

		
func _physics_process(delta):
	get_input()
	
	if velocity == Vector2.ZERO and Input.is_action_just_released("right"):
		$AnimatedSprite2D.play("idle_right")

	elif velocity == Vector2.ZERO and Input.is_action_just_released("left"):
		$AnimatedSprite2D.play("idle_left")

	elif velocity.x == (1 * speed):
		$AnimatedSprite2D.play("walk_left")
	elif velocity.x == (-1 * speed):
		$AnimatedSprite2D.play("walk_right")
		
		
		
		
	if is_on_floor():
		#print("Player on floor")
		jump_timing = 0
	if velocity.y <= ((-1 * 144)):
		jump_timing += 1
		#print("Player in air")
	else:
		velocity.y = delta * gravity
		#print("playeer falling")
	
	if jump_timing >= 20:
		#print("player will fall")
		velocity.y = (1 * speed)
		
		
	

	#print(mouse_position)
	#print(velocity)
	move_and_slide()
	
