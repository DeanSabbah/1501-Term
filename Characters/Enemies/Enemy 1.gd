extends Enemy;
signal death_anim

var projectileScene = preload("res://Scenes/Weapons/Enemy_Projectile.tscn")

func attack():
	print("HERE!!!")
	cooldownTimer.start()
	var projectile = projectileScene.instantiate()
	#print("PROJECTILE POSITION: ", projectile.positon)
	projectile.damage = attackDamage
	get_parent().add_child(projectile)
