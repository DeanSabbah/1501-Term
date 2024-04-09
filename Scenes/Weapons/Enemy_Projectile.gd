class_name Enemy_Projectile extends Projectile

func _ready():
	direction = (player.position - position).normalized()
	self.rotation = direction.angle()
