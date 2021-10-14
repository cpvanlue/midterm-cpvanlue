extends KinematicBody2D


signal player_bounce
signal body_hit

var velocity := Vector2(-250,0)
var lethal := true


func _physics_process(delta: float) -> void:
	var value := move_and_collide(velocity * delta)
	if value:
		if (value.collider.name == "TileMap") or ("Enemy" in value.collider.name):
			$AnimatedSprite.flip_h = !$AnimatedSprite.flip_h
			velocity.x = -velocity.x
		elif value.collider_shape and value.collider_shape.name == "Ray":
			emit_signal("player_bounce")
			$AnimatedSprite.animation = "dead"
			$CollisionShape2D.queue_free()
			$Timer.start(0.1); yield($Timer, "timeout")
			self.queue_free()
		elif lethal:
			emit_signal("body_hit")
			lethal_recovery()


func lethal_recovery() -> void:
	lethal = false
	$RecoveryTimer.start(1); yield($RecoveryTimer, "timeout")
	lethal = true
	
