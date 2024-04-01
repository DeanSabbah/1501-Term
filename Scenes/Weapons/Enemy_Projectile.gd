class_name Enemy_Projectile extends Projectile

func _init(parent_position:Vector2, attackDamage:int):
	position = parent_position
	damage = attackDamage

func _ready():
	direction = (player.position - position).normalized()
	self.rotation = direction.angle()
	print(speed)