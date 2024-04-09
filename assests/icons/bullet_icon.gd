extends Area2D
@onready var player = self.get_parent().get_node("player")


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_entered(area:Area2D):
	player.reset_ammo()
	pass
