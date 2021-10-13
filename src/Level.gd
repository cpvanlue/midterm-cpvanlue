extends Node2D


const COIN := preload("res://src/Coin.tscn")

var score := 0

func _ready():
	var coins = $TileMap.get_used_cells_by_id(22)
	replaceCoins(coins)
	
	
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
		

func _on_Coin_Get() -> void:
	score += 10
	print("Score: " + str(score))


func _on_KillZone_body_entered(body: PhysicsBody2D) -> void:
	if body.name == "Player":
		$Player.velocity = Vector2(0,0)
		$Player/AnimationPlayer.play("Die")
		yield(get_tree().create_timer(1), "timeout")
		body.queue_free()
