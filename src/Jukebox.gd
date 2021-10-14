extends Node2D


func toggle_background() -> void:
	$Background.play()
	
	
func play_coin() -> void:
	$Coin.play()


func play_win() -> void:
	$Win.play()


func play_enemy() -> void:
	$EnemyDeath.play()


func play_select() -> void:
	$Select.play()
