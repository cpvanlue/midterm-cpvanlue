extends CanvasLayer


func _ready() -> void:
	$AnimationPlayer.play("Load")
	Jukebox.toggle_background()


func _process(_delta: float) -> void:
	if Input.is_action_pressed("ui_accept"):
		_on_Button_pressed()


func _on_Button_pressed() -> void:
	Jukebox.play_select()
	var _ignored = get_tree().change_scene("res://src/Level.tscn")
