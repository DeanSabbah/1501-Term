extends CharacterBody2D

@export var speed:int
@export var jump_strength:int # Adjusted for a more noticeable jump

var gravity = 20
var mouse_position = get_global_mouse_position()
var projectileScene = preload("res://Scenes/Weapons/Projectile.tscn")
var xp:int = 0
var level:int = 1
var nextLevel:int = 50

@onready var progress_bar = $Camera2D/HUD/ProgressBar

signal leveled_up(nextLevel:int, xp:int)
signal got_xp(xp:int)

func _ready():
	leveled_up.connect(progress_bar.level_up)
	got_xp.connect(progress_bar.set_xp)
	leveled_up.emit(level, nextLevel, xp)

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
	var parent = get_node("/root/Main")
	if event is InputEventMouseButton:
		if (event.button_index == MOUSE_BUTTON_LEFT and event.pressed):
			var projectile = projectileScene.instantiate()
			projectile.damage = 10
			parent.add_child(projectile)

func get_player_position():
	return position

func get_player_velocity():
	return velocity


func give_xp():
	xp += 25
	print("PLAYER XP: ", xp)
	got_xp.emit(xp)
	while(xp >= nextLevel):
		level_up()

func level_up():
	level += 1
	nextLevel = ceil(nextLevel * 1.5)
	print("YOU LEVELED UP TO: ", level)
	print("NEXT LEVEL AT: ", nextLevel)
	print("---------------------------")
	leveled_up.emit(nextLevel, xp)

