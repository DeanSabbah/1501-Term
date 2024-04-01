extends Control
@export var mouse_position = Vector2.ZERO
var crosshair_distance = 200


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	
func _process(delt):
	var player_pos = get_parent().position
	var mouse_pos = get_global_mouse_position()
	var direction = (mouse_pos - player_pos).normalized()
	var crosshair_position = player_pos + direction * crosshair_distance
	self.position = crosshair_position + Vector2(-30, -25)

func get_cursor_location():
	return self.position

func get_direction():
	var player_pos = get_parent().position
	var mouse_pos = get_global_mouse_position()

	var direction = (mouse_pos - player_pos).normalized()
	return direction
