extends Area2D


signal coin_get


func _on_Coin_body_entered(body: RigidBody2D) -> void:
	if body.name == "Player":
		emit_signal("coin_get")
		queue_free()
