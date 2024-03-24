extends CharacterBody2D

@export var speed = 400
@export var jump_strength = -500 # Adjusted for a more noticeable jump
var gravity = 20
var mouse_position = get_global_mouse_position()
var projectileScene = preload("res://Projectile.tscn")

func _physics_process(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity.x = input_direction.x * speed
	
	# Handle jumping
	if is_on_floor() and Input.is_action_just_pressed("up"):
		velocity.y = jump_strength
	elif not is_on_floor():
		velocity.y += gravity
	
	# Update animations based on movement
	update_animations()
	
	# Move the character
	move_and_slide()

func _process(delta):
	pass

func update_animations():
	var animation = ""

	#determine if the player is moving or not
	var flag_idle
	if (velocity.x == 0):
		flag_idle = true
	else:
		flag_idle = false
	
	# based on the mouse position, flip the sprite
	mouse_position = get_global_mouse_position()
	
	# if mouse to the left play left
	if mouse_position.x < position.x:
		if flag_idle:
			animation = "idle_left"
		else:
			animation = "walk_left"
	
	# if mouse to the right play right
	else:
		if flag_idle:
			animation = "idle_right"
		else:
			animation = "walk_right"

	$AnimatedSprite2D.play(animation)


func _input(event):
	var parent = get_parent()
	if event is InputEventMouseButton:
		if (event.button_index == MOUSE_BUTTON_LEFT and event.pressed):
			var projectile = projectileScene.instantiate()
			parent.add_child(projectile)
			

func get_player_position():
	return position

func get_player_velocity():
	return velocity

	# var mouse_location = get_parent().get_child(0).get_child(0).get_cursor_location()
	
	# print("mouse position: ", mouse_location)
	# print("player velocity: ", velocity)
 	# print("player position: ", get_player_position())

 	# var player_animation_2D = get_child(0)

 	# if (mouse_location.x <= position.x):
 	# 	player_animation_2D.play("idle_left")
 	# else:
	# 	player_animation_2D.play("idle_right")
	# pass
