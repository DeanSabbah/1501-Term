class_name Player extends CharacterBody2D

@export var speed:int
@export var jump_strength:int 
@export var health:int
@export var ammo:int
@export var stamina_amount:int
@onready var hud = $Camera2D/HUD
@onready var reloaded = true

#var credits_scene = preload(
var gravity = 20
var mouse_position = get_global_mouse_position()
var projectileScene = preload("res://Scenes/Weapons/Projectile.tscn")
var original_stamina: int
var xp:int = 0
var level:int = 1
var nextLevel:int = 50
var health_multiplier:float = 1.1
var original_ammo:int
var ammo_difference = 0
var original_health:int
var sprinting:bool = false
var dying:bool = false
var jump_in_air_counter:int = 0

signal leveled_up(level, nextLevel:int, xp:int)
signal got_xp(xp:int)
signal health_changed(health)
signal ammo_changed(ammo)
signal stamina_changed(stamina_amount)
signal health_icon(health)
signal died()

func _ready():
			#_____________________________
	#original_health = health
	#leveled_up.connect(hud.level_up)
	#got_xp.connect(hud.set_xp)
	#leveled_up.emit(level, nextLevel, xp)
	#health_changed.connect(hud.set_health)
	#health_changed.emit(health)
	#stamina_changed.connect(hud.on_stamina)
	#original_stamina = stamina_amount
	#health_icon.connect(hud.on_health)
	#health_icon.emit(health)
		#_____________________________
	leveled_up.connect(hud.level_up)
	got_xp.connect(hud.set_xp)
	leveled_up.emit(level, nextLevel, xp)
	health_changed.connect(hud.set_health)
	health_changed.emit(health)
	stamina_changed.connect(hud.on_stamina)
	original_stamina = stamina_amount
	health_icon.connect(hud.on_health)
	health_icon.emit(health)
	original_ammo = ammo
	original_stamina = stamina_amount

func _physics_process(delta):
	var input_direction = Input.get_vector("left", "right", "up", "down")
	velocity.x = input_direction.x * speed * 60 * delta
	
	
	# Handle jumping
	if is_on_floor() and Input.is_action_just_pressed("up") and stamina_amount >= 50:
		velocity.y = jump_strength * delta * 60
		jump_in_air_counter = 0
		stamina_amount -= 50
	elif not is_on_floor() and Input.is_action_just_pressed("up") and jump_in_air_counter == 0 and stamina_amount >= 50:
		velocity.y = jump_strength * delta * 60
		jump_in_air_counter += 1
		stamina_amount -= 50
	elif not is_on_floor():
		velocity.y += gravity * delta * 60
		
	
	
	# Update animations based on movement
	update_animations()
	
	# Move the character
	move_and_slide()


	if Input.is_action_pressed("shift") and stamina_amount > 0:
		if(!sprinting):
			speed += 200
			sprinting = true
		stamina_amount -= 1
		stamina_changed.emit(stamina_amount)
	elif Input.is_action_just_released("shift") or stamina_amount <= 0:
		if(sprinting):
			speed -= 200
			sprinting = false
	if !sprinting and stamina_amount < original_stamina and !Input.is_action_pressed("shift"):
			stamina_amount += 1
			stamina_changed.emit(stamina_amount)

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
	if !dying:
		$AnimatedSprite2D.play(animation)

# shooting
func _input(event):
	if event is InputEventMouseButton and reloaded:
		if (event.button_index == MOUSE_BUTTON_LEFT and event.pressed):
			#if no ammo
			if (ammo <= 0):
				print("OUT OF AMMO!!!, MUST RELOAD")
				reloaded = !reloaded
				return

			var projectile = projectileScene.instantiate()
			projectile.damage = 10
			ammo -= 1

			ammo_changed.connect(hud.set_ammo)
			ammo_changed.emit(ammo)

			get_parent().add_child(projectile)
			$Shoot.play()
	elif event is InputEventMouseButton:
		$Empty.play()

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
	dying = true
	#play death dound
	$Death.play()
	process_mode = Node.PROCESS_MODE_ALWAYS
	get_tree().paused = true
	$AnimatedSprite2D.play("death")
	await get_tree().create_timer(1).timeout # wait 1 secs
	hide()
	await get_tree().create_timer(1.1).timeout # wait 2.1 secs
	$CollisionBox.set_deferred("disabled", true)
	#animation_node.play("death")
	#await get_tree().create_timer(0.8).timeout
	# TODO: Better death handling
	#_____________________
	# get_tree().change_scene_to_file("res://scenes/credits/GodotCredits.tscn")
	# get_tree().change_scene_to_file("res://scene/Start screen/start.tscn")
	#_____________________
	process_mode = Node.PROCESS_MODE_DISABLED
	died.emit()

func give_xp(xp_in):
	xp += xp_in
	print("PLAYER XP: ", xp)
	got_xp.emit(xp)
	while(xp >= nextLevel):
		level_up()

func level_up():
	original_health = ceil(health*health_multiplier)
	give_health()
	health_multiplier += 0.1
	print("MAX HEALTH IS:", health)
	level += 1
	nextLevel = ceil(nextLevel * 1.5)
	print("YOU LEVELED UP TO: ", level)
	print("NEXT LEVEL AT: ", nextLevel)
	print("---------------------------")
	leveled_up.emit(level, nextLevel, xp)

func reset_ammo():
	if (ammo == original_ammo):
		return
	
	get_node("/root/world/Reload").play()
	reloaded = true
	print("original ammo after reset: ", ammo)
	print("ORIGINAL AMMO:")
	ammo = original_ammo
	#print(original_ammo)
	print("ammo after: ", ammo)
	ammo_difference = 0
	hud.reset_ammo()

func give_stamina():
	print("original stamina: ", original_stamina)
	stamina_amount = original_stamina
	stamina_changed.emit(stamina_amount)

func give_health():
		#_____________________________
	#print ("original health:", original_health)
	#health = original_health
	#health_icon.emit(health)
	#_____________________________
	

	print ("original health:", original_health)
	if (health <= (health * 1.5)):
		health *= 2
	else:
		health = original_health
	health_icon.emit(health)


func _on_hit_box_area_body_entered(body:Node2D):
	if(body is Enemy):
		die()
