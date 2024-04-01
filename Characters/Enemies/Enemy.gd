class_name Enemy extends CharacterBody2D

@onready var player = get_node("/root/Main/player")
@onready var cooldownTimer = $Cooldown
@onready var animation_node = get_node("AnimationPlayer")
#@onready var animations = $AnimationPlayer

@export var attackRange:int
@export var viewRange:int
@export var attackDamage:int
@export var speed:int
@export var maxHealth:int = 100
@export var expDrop:int = 10
@export var cooldown:float

var health:int = maxHealth
var inside:bool
var inRange:bool

func _ready():
	animation_node.play("idle")
	$ViewRange/CollisionShape2D.shape.radius = viewRange
	$AttackRange/CollisionShape2D.shape.radius = attackRange
	cooldownTimer.wait_time = cooldown
	health = maxHealth

func attack():
	pass

func on_death():
	pass

func _on_viewRange_body_entered(body:Node2D):
	if body == player:
		inside = true

func _on_viewRange_body_exited(body:Node2D):
	if body == player:
		inside = false

func _on_attack_range_body_entered(body:Node2D):
	if body == player:
		inRange = true

func _on_attack_range_body_exited(body:Node2D):
	if body == player:
		inRange = false

func _physics_process(delta):
	if cooldownTimer.is_stopped() and inRange:
		animation_node.stop()
		attack()
	elif !animation_node.is_playing():
		animation_node.play("idle")
	

func _on_hit_box_area_entered(area):
	if area is Projectile:
		print("AREA DAMAGE: ", area.damage)
		take_damage(area.damage)
		area.queue_free()

func take_damage(amount: int):
	health -= amount
	print("ENEMY HEALTH: ", health)
	
	if (health <= 0):
		#var collision = get_node("CollisionBox")
		#collision.disable = true
		$CollisionBox.disabled = true
		await death_animation()
		die()


func die():
	#PLAY SOME ANIMATION BEFORE DYING .. ?
	player.give_xp()
	
	# deletes the enemy
	queue_free()


func death_animation():
	animation_node.play("death")
	await get_tree().create_timer(0.8).timeout