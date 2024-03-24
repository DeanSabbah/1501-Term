extends Area2D

var speed = 4000
var direction = Vector2.ZERO # Initialized to a zero vector

func _ready():
	direction = get_parent().get_node("player/Crosshair").get_direction()
	self.position = get_parent().get_node("player").get_player_position()

func _process(delta):
	self.position += direction * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
