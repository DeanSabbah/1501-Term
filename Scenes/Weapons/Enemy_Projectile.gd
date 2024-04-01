extends Projectile

func _ready():
	self.position = get_parent().position
	direction = (player.position - self.position).normalized()
	self.rotation = direction.angle()