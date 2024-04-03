extends Enemy;
signal death_anim

var projectileScene = preload("res://Scenes/Weapons/Enemy_Projectile.tscn")

func attack():
	print("ENEMY ATTACKING PLAYER")
	cooldownTimer.start()
	var projectile = projectileScene.instantiate()
	print("ENEMY SHOOTING PROJECTILE: ", projectile)
	projectile.position = position
	projectile.damage = attackDamage
	get_parent().add_child(projectile)

