extends Area2D

signal coin_get

func _on_Coin_body_entered(_body):
	emit_signal("coin_get")
	queue_free()