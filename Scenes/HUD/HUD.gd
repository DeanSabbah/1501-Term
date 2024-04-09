extends CanvasLayer

@onready var progress_bar = $ProgressBar
@onready var level_label = $"Level Label"
@onready var health_bar = $HealthBar 
@onready var ammo_bar = $ammoBar
@onready var player = self.get_parent().get_parent()
@onready var player_original_ammo = player.ammo
@onready var ammo_label = $ammoLabel
@onready var stamina_bar = $staminaBar
@onready var stamina_label = $staminaLabel
func _ready():
	
	progress_bar.value = 0
	progress_bar.min_value = 0
	progress_bar.max_value = 100

	health_bar.value = 0 
	health_bar.min_value = 0
	health_bar.max_value = 100
	
	ammo_bar.min_value = 0
	ammo_bar.max_value = player_original_ammo
	ammo_label.text = str(player_original_ammo)

	stamina_bar.min_value = player.stamina_amount
	stamina_bar.max_value = player.stamina_amount


func set_health(health: int):
	health_bar.value = health 

func set_max_health(max_health: int):
	health_bar.max_value = max_health	

func set_xp(xp:int):
	progress_bar.value = xp

func set_ammo(ammo_count: int):

	#ammo_bar.max_value = ammo_count
	ammo_bar.value = ammo_count
	print("ammo count: ", ammo_bar.value)



func level_up(level:int, nextLevel:int, xp:int):
	progress_bar.min_value = progress_bar.max_value
	progress_bar.max_value = nextLevel
	progress_bar.value = xp
	level_label.text = "Level %d" % level

func reset_ammo():
	ammo_bar.value = player_original_ammo
	ammo_bar.min_value = 0
	ammo_bar.max_value = player_original_ammo
	ammo_label.text = str(player_original_ammo) + "/ " + str(player_original_ammo)
	
func on_stamina(stamina_changing:int):
	stamina_bar.min_value = 0
	stamina_bar.value = stamina_changing
	stamina_label.text = "Stamina"

func on_health(health_changing:int):
	pass
