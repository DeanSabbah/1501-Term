class_name Player extends CharacterBody2D

@export var speed:int
@export var jump_strength:int 
@export var health:int
@export var ammo:int
@onready var hud = $Camera2D/HUD
@onready var reloaded = true

var gravity = 20
var mouse_position = get_global_mouse_position()
var projectileScene = preload("res://Scenes/Weapons/Projectile.tscn")
#var progressbar = preload("res://Scenes/HUD/hud.tscn")
var xp:int = 0
var level:int = 1
var nextLevel:int = 50
var health_multiplier:float = 1.1
var original_ammo:int = 0
var ammo_difference = 0
signal leveled_up(level, nextLevel:int, xp:int)
signal got_xp(xp:int)
signal health_changed(health)
signal ammo_changed(ammo)

func _ready():
	leveled_up.connect(hud.level_up)
	got_xp.connect(hud.set_xp)
	leveled_up.emit(level, nextLevel, xp)
	health_changed.connect(hud.set_health)
	health_changed.emit(health)
	


func _physics_process(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity.x = input_direction.x * speed * 60 * delta
	
	# Handle jumping
	if is_on_floor() and Input.is_action_just_pressed("up"):
		velocity.y = jump_strength * delta * 60
	elif not is_on_floor():
		velocity.y += gravity * delta * 60
	
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
	if event is InputEventMouseButton and reloaded:
		if (event.button_index == MOUSE_BUTTON_LEFT and event.pressed):
			var projectile = projectileScene.instantiate()
			projectile.damage = 10
			ammo -= 1
			ammo_difference += 1
			if (ammo <= 0):
				print("OUT OF AMMO!!!, MUST RELOAD")
				reloaded = !reloaded
				
			ammo_changed.connect(hud.set_ammo)
			ammo_changed.emit(ammo)

			get_parent().add_child(projectile)

func _on_hit_box_area_entered(area):
	if area is Enemy_Projectile:
		print("AREA DAMAGE: ", area.damage)
		take_damage(area.damage)
		area.queue_free()

func take_damage(amount: int):
	health -= amount
	print("PLAYER HEALTH: ", health)
	health_changed.emit(health)
	if (health <= 0):
		die()

func die():
	$CollisionBox.set_deferred("disabled", true)
	#animation_node.play("death")
	#await get_tree().create_timer(0.8).timeout
	#_____________________
	get_tree().quit()
	#_____________________

func give_xp(xp_in):
	xp += xp_in
	print("PLAYER XP: ", xp)
	got_xp.emit(xp)
	while(xp >= nextLevel):
		level_up()

func level_up():
	health = round(100 * health_multiplier)
	health_multiplier += 0.1
	print("MAX HEALTH IS:", health)
	health_changed.emit(health)	
	level += 1
	nextLevel = ceil(nextLevel * 1.5)
	print("YOU LEVELED UP TO: ", level)
	print("NEXT LEVEL AT: ", nextLevel)
	print("---------------------------")
	leveled_up.emit(level, nextLevel, xp)

func reset_ammo():
	#print("RESETING AMMO")
	reloaded = true
	print("original ammo after reset: ", ammo)
	print("ORIGINAL AMMO:")
	original_ammo = ammo + ammo_difference
	print(original_ammo)
	ammo = original_ammo
	print("ammo after: ", ammo)
	ammo_difference = 0
	hud.reset_ammo()
