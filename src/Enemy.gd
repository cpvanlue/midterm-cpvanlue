extends KinematicBody2D


var velocity = Vector2(-250,0)


func _physics_process(delta: float):
	var value := move_and_collide(velocity * delta)
	if value:
		if (value.collider.name == "TileMap") or ("Enemy" in value.collider.name):
			$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
			velocity.x = -velocity.x
