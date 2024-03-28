extends CanvasLayer

@onready var progress_bar = $ProgressBar
@onready var level_label = $"Level Label"

func _ready():
	progress_bar.value = 0
	progress_bar.min_value = 0
	progress_bar.max_value = 100
	

func set_xp(xp:int):
	progress_bar.value = xp

func level_up(level:int, nextLevel:int, xp:int):
	progress_bar.min_value = progress_bar.max_value
	progress_bar.max_value = nextLevel
	progress_bar.value = xp
	level_label.text = "Level %d" % level
