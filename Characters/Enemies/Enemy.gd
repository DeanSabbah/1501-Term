class_name Enemy extends CharacterBody2D

@onready var player:Player = get_node("/root/Main/player")
@onready var cooldownTimer = $Cooldown
@onready var animation_node = get_node("AnimationPlayer")
@onready var death_animation_node = get_node("Death anim")
@onready var collider = $RayCast2D

@export var attackRange:int
@export var viewRange:int
@export var attackDamage:int
@export var speed:int
@export var maxHealth:int = 100
@export var expDrop:int
@export var cooldown:float

var health:int = maxHealth
var inView:bool
var inRange:bool
var dying:bool = false

signal attacking(body:Node2D)

func _ready():
	animation_node.play("idle")
	$ViewRange/CollisionShape2D.shape.radius = viewRange
	$AttackRange/CollisionShape2D.shape.radius = attackRange
	cooldownTimer.wait_time = cooldown
	health = maxHealth
	if is_instance_valid(death_animation_node):
		
		death_animation_node.hide()


func attack():
	pass

func on_death():
	pass

func _on_viewRange_body_entered(body:Node2D):
	if body == player:
		inView = true

func _on_viewRange_body_exited(body:Node2D):
	if body == player:
		inView = false

func _on_attack_range_body_entered(body:Node2D):
	if body == player:
		inRange = true

func _on_attack_range_body_exited(body:Node2D):
	if body == player:
		inRange = false

func _process(delta):	
	if cooldownTimer.is_stopped() and inRange and !dying:
		animation_node.stop()
		attack()
	elif !animation_node.is_playing() and !dying:
		animation_node.play("idle")
	
	if (player.position.x < position.x):
		$Sprite2D.flip_h = true
	else:
		$Sprite2D.flip_h = false
	
	collider.target_position = player.position - position
	### TODO: ADD RAYCASTING SUPPORT ###
	#if(collider.get_collider() == player and inView):
	if inView:
		velocity = (player.position - position).normalized() * speed * delta * 60
	elif(!inView):
		velocity = Vector2.ZERO
	# elif(inView):
	# 	velocity = (player.position - position).normalized() * speed * delta
	move_and_slide()

#func _physics_process(delta):



func _on_hit_box_area_entered(area):
	if area is Projectile and !(area is Enemy_Projectile):
		take_damage(area.damage)
		area.queue_free()

func take_damage(amount: int):
	health -= amount
	print("ENEMY HEALTH: ", health)
	
	if (health <= 0):
		die()


func die():
	$CollisionBox.set_deferred("disabled", true)
	if is_instance_valid(death_animation_node):
		death_animation_node.show()
	player.give_xp(expDrop)
	dying = true
	animation_node.play("death")
	await get_tree().create_timer(0.8).timeout
	# deletes the enemy
	queue_free()
