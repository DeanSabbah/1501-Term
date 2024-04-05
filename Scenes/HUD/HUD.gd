extends CanvasLayer

@onready var progress_bar = $ProgressBar
@onready var level_label = $"Level Label"
@onready var health_bar = $HealthBar 

func _ready():
	progress_bar.value = 0
	progress_bar.min_value = 0
	progress_bar.max_value = 100

	health_bar.value = 0 
	health_bar.min_value = 0
	health_bar.max_value = 100
	
func set_health(health: int):
	health_bar.value = health 

func set_max_health(max_health: int):
	health_bar.max_value = max_health	

func set_xp(xp:int):
	progress_bar.value = xp
	

func level_up(level:int, nextLevel:int, xp:int):
	progress_bar.min_value = progress_bar.max_value
	progress_bar.max_value = nextLevel
	progress_bar.value = xp
	level_label.text = "Level %d" % level
