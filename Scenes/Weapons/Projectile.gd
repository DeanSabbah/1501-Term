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


func _on_body_entered(body:Node2D):


	var map1_node = get_node(get_parent().get_node("Industrial").get_path())
	var map2_node = get_node(get_parent().get_node("Exclusion").get_path())

	
	var tilemap1 = map1_node.get_node("Industiral")
	var tilemap2 = map2_node.get_node("Exclusion")


	if (body == tilemap1 or body == tilemap2):
		queue_free()


	pass
