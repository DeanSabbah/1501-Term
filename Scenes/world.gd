extends Node2D

@onready var player = $player

@export var start:PackedScene
@export var credits:PackedScene

var enemy_count:int = 0
#var credit_scene = preload("res://scenes/credits/GodotCredits.tscn").instantiate()

# Called when the node enters the scene tree for the first time.
func _ready():
	player.died.connect(Callable(self, "lose"))
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
	#get_tree().change_scene_to_packed(credit_scene)

func lose():
	print("wow lol u suk")
	Global.switch_scene(start.get_path())
	print("those credits were fly broooo")
