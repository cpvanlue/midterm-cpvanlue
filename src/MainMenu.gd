extends CanvasLayer



func _ready() -> void:
	$AnimationPlayer.play("Load")


func _process(_delta):
	if Input.is_action_pressed("ui_accept"):
		_on_Button_pressed()


func _on_Button_pressed() -> void:
	var _ignored = get_tree().change_scene("res://src/Level.tscn")
