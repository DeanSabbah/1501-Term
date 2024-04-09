extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	if event.is_action_pressed("pause"):
		get_tree().paused = !get_tree().paused
		# if true show label
		if get_tree().paused:
			$CanvasLayer/Label.show()
		else:
			$CanvasLayer/Label.hide()

		
