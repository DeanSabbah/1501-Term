class_name Projectile extends Area2D

@export var speed:int = 4000
var direction = Vector2.ZERO # Initialized to a zero vector
var damage:int

func _ready():
	direction = get_parent().get_node("player/Crosshair").get_direction()
	self.position = get_parent().get_node("player").position
	self.rotation = direction.angle()

func _process(delta):
	self.position += direction * speed * delta

func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
