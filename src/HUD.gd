extends CanvasLayer


signal replay


func _on_PlayAgain_pressed() -> void:
	emit_signal("replay")


func _on_Quit_pressed() -> void:
	get_tree().quit()
