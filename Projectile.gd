extends Area2D

var speed = 400
var direction = Vector2.ZERO # Initialized to a zero vector

func _ready():
	direction = get_parent().get_child(3).get_child(0).get_direction()
	self.position = get_parent().get_child(2).get_player_position()

func _process(delta):
	self.position += direction * speed * delta


func _on_visible_on_screen_notifier_2d_screen_exited():
	queue_free()
