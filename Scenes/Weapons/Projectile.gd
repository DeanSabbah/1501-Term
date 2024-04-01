class_name Projectile extends Area2D

@export var speed:int = 4000
var direction = Vector2.ZERO # Initialized to a zero vector
var damage:int

@onready var player = get_node("/root/Main/player")

func _ready():
	print(player)
	direction = player.get_node("Crosshair").get_direction()
	self.position = player.position
	self.rotation = direction.angle()

func _process(delta):
	self.position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()

func _on_body_entered(body:Node2D):
	if (body is TileMap):
		queue_free()