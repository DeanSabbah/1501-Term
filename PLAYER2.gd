extends CharacterBody2D
@export var speed = 400
@export var jump_timing = 0
const gravity = 10000
var shooting = false
signal shoot

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
	
	
	if (Input.is_action_just_pressed("left_click")):
		shooting = true
		emit_signal("shoot")
		
	velocity = input_direction * speed

		
func _physics_process(delta):
	get_input()
	
	if velocity == Vector2.ZERO and Input.is_action_just_released("right"):
		$AnimatedSprite2D.play("idle_left")

	elif velocity == Vector2.ZERO and Input.is_action_just_released("left"):
		$AnimatedSprite2D.play("idle_right")

	elif velocity.x == (1 * speed):
		$AnimatedSprite2D.play("walk_left")
	elif velocity.x == (-1 * speed):
		$AnimatedSprite2D.play("walk_right")
		

		
		
	if is_on_floor():

		jump_timing = 0
	if velocity.y <= ((-1 * 144)):
		jump_timing += 1

	else:
		velocity.y = delta * gravity

	
	if jump_timing >= 20:
		velocity.y = (1 * speed)
		
		
	move_and_slide()
	shooting_bullet(shooting)

func get_player_position():
	while (velocity.y > 0):
		return position
	var no_jump_position = position
	no_jump_position.y = 0
	return no_jump_position

func shooting_bullet(shooting):
	if (shooting == false):
		pass
		
	pass
