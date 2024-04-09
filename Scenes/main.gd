extends Node2D

@onready var player = $player

var enemy_count:int = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	$Music.play()
	$Music.stream.loop = true
	var children = get_children()
	for child in children:
		if child is Enemy:
			child.dying_signal.connect(Callable(self, "enemy_dead"))
			enemy_count += 1
	print(enemy_count)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func enemy_dead():
	enemy_count -= 1
	if(enemy_count <= 0):
		win()

func win():
	print("Congratulations, you win!!!")
