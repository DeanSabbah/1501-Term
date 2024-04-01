extends Enemy;
signal death_anim

var projectileScene = preload("res://Scenes/Weapons/Enemy_Projectile.tscn")

func attack():
	print("attacking")
	cooldownTimer.start()
	var projectile = Enemy_Projectile.new(self.position, attackDamage)
	get_parent().add_child(projectile)