extends KinematicBody2D

signal player_bounce

var velocity = Vector2(-250,0)


func _physics_process(delta: float):
	var value := move_and_collide(velocity * delta)
	if value:
		if (value.collider.name == "TileMap") or ("Enemy" in value.collider.name):
			$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
			velocity.x = -velocity.x
		if value.collider_shape and value.collider_shape.name == "Ray":
			emit_signal("player_bounce")
			$AnimatedSprite.animation = "dead"
			$CollisionShape2D.queue_free()
			$Timer.start(0.1); yield($Timer, "timeout")
			self.queue_free()
