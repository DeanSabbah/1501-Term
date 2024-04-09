class_name Enemy2 extends Enemy

var gravity = 20

func _physics_process(delta):
	print("enemy 2 inview:", inView)
	if inView:
		var player_pos = player.position
		player_pos.y = position.y
		velocity.x = (player_pos.x - position.x).normalized() * speed * delta * 60
	elif(!inView):
		velocity = Vector2.ZERO
	if not is_on_floor():
		velocity.y += gravity * delta * 60
	if not $Direction/RayCast2D2.is_colliding() and not $Direction/RayCast2D2.get_collider() is TileMap:
		velocity.x = -velocity.x
		$Direction.scale.x = -$Direction.scale.x

	move_and_slide()

