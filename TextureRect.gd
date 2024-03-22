class_name cursor extends TextureRect
@export var mouse_position = Vector2.ZERO


func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	pass



func _process(delta):	
	mouse_position = get_viewport().get_mouse_position()
	self.position = mouse_position + Vector2(-30, -25)
	
	pass
	

func get_cursor_location():
	return self.position
