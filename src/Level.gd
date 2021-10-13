extends Node2D


const COIN = preload("res://src/Coin.tscn")

func _ready():
	var coins = $TileMap.get_used_cells_by_id(22)
	replaceCoins(coins)
	
func replaceCoins(positionArray: Array):
	var tilePosition
	for i in range(0, positionArray.size()):
		var coin = COIN.instance()
		tilePosition = $TileMap.map_to_world(positionArray[i])
		coin.position.x = tilePosition.x + 64
		coin.position.y = tilePosition.y + 64
		$TileMap.set_cell(positionArray[i].x, positionArray[i].y, -1)
		$TileMap.add_child(coin)


