extends TextureRect
const crosshair_distance = 200

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	

func _process(delta):

	# get player and mouse position
	var player_pos = get_parent().get_parent().get_child(2).get_player_position()
	var mouse_pos = get_global_mouse_position()

	# get the direction from the player to the mouse
	var direction = (mouse_pos - player_pos).normalized()
	
	# get the crosshair position
	var crosshair_pos = player_pos + (direction * crosshair_distance)
	
	# the final mouse cursor is the crosshair's radius PLUS the cursor image 
	# offset (to center the image)
	self.position = crosshair_pos + Vector2(-30, -25)



# get the cursor location if needed
func get_cursor_location():
	return self.position

func get_direction():
	var player_pos = get_parent().get_parent().get_child(2).get_player_position()
	var mouse_pos = get_global_mouse_position()

	var direction = (mouse_pos - player_pos).normalized()
	return direction