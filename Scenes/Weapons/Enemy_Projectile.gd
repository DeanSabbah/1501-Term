class_name Enemy_Projectile extends Projectile

func _ready():
	print(speed)
	direction = (player.position - position).normalized()
	self.rotation = direction.angle()
