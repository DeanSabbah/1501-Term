class_name cursor extends TextureRect
@export var mouse_position = Vector2.ZERO


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass



func _process(delta):	
	mouse_position = get_viewport().get_mouse_position()
	self.position = mouse_position + Vector2(-30, -25)
	var min = Vector2(0, 0)
	var max = Vector2(1152, -648)
	
	var mouse_position_boundaries = self.position.clamp(min, max)

	if (self.position != mouse_position_boundaries):
		self.position = mouse_position_boundaries
	pass
	

func get_cursor_location():
	return self.position
