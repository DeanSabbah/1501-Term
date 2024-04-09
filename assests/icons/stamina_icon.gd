extends Area2D
@onready var player = self.get_parent().get_node("player")
@onready var player_hitbox = player.get_node("HitBoxArea")
@onready var animation_node = get_node("AnimationPlayer")
func _ready():
	animation_node.play("idle")
	pass


func _process(delta):
	pass


func _on_area_entered(area:Area2D):
	if (area == player_hitbox):
		player.give_stamina()
		queue_free()

