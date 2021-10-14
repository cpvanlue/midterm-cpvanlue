extends Node2D


const COIN := preload("res://src/Coin.tscn")

var score := 0
var timer

func _ready()-> void:
	var coins = $TileMap.get_used_cells_by_id(22)
	replaceCoins(coins)
	game_Timer()
	var enemies = get_tree().get_nodes_in_group("Enemies")
	for enemy in enemies:
		enemy.connect("player_bounce", self, "_on_Coin_Get")
		enemy.connect("body_hit", self, "_on_Body_Hit")
	var _ignored = $HUD.connect("replay", self, "_on_Replay")
	$HUD/Labels.visible = true


func _process(_delta: float) -> void:
	$HUD/Labels/ScoreLabel.text = "Score: " + str(score)
	$HUD/Labels/TimerLabel.text = str(int($Timer.get_time_left()))


func replaceCoins(positionArray: Array) -> void:
	var tilePosition
	for i in range(0, positionArray.size()):
		var coin = COIN.instance()
		tilePosition = $TileMap.map_to_world(positionArray[i])
		coin.position.x = tilePosition.x + 64
		coin.position.y = tilePosition.y + 64
		coin.connect("coin_get", self, "_on_Coin_Get")
		$TileMap.set_cell(positionArray[i].x, positionArray[i].y, -1)
		$TileMap.add_child(coin)


func game_Timer() -> void:
	$Timer.start(181); yield($Timer, "timeout")
	$HUD/Labels.visible = false
	_on_KillZone_body_entered($Player)


func _on_Replay() -> void:
	var _ignored = get_tree().change_scene("res://src/MainMenu.tscn")
	get_tree().paused = false


func _on_Coin_Get() -> void:
	score += 10


func _on_Body_Hit() -> void:
	score -= 10
	if score < 0:
		score = 0


func _on_KillZone_body_entered(body: PhysicsBody2D) -> void:
	if body.name == "Player":
		$HUD/Labels.visible = false
		$Player.velocity = Vector2(0,0)
		$Player/AnimationPlayer.play("Die")
		yield(get_tree().create_timer(1), "timeout")
		body.queue_free()
		$HUD/GameOverHUD/ColorRect/ScoreLabel.text = "Score: " + str(score)
		$HUD/GameOverHUD.visible = true
	if body.name == "Enemy":
		body.queue_free()


func _on_Flag_body_entered(body):
	if body.name == "Player":
		get_tree().paused = true
		pause_mode = PAUSE_MODE_PROCESS
		$HUD/Labels.visible = false
		$Timer.paused = true
		score += $Timer.get_time_left() * 100
		$Flag/AnimatedSprite.animation = "active"
		$HUD/GameOverHUD/ColorRect/GameOver.text = "You Win!"
		$HUD/GameOverHUD/ColorRect/ScoreLabel.text = "Score: " + str(score)
		$HUD/GameOverHUD.visible = true
