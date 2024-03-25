extends ProgressBar

func _ready():
	value = 0
	min_value = 0
	max_value = 100
	

func set_xp(xp:int):
	value = xp

func level_up(nextLevel:int, xp:int):
	min_value = max_value
	max_value = nextLevel
	value = xp