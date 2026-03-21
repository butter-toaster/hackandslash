extends Node2D
var grave = preload("res://images/fate.png")

func _ready() -> void:
	%bar3.position.x = 10000
	%bar4.position.x = 10000
	if GameManager.graveyard == false:
		GameManager.graveyard = true
		await get_tree().create_timer(1.5).timeout
		%ACHIEVEMENTHANDLER._achactivate(%graveyard)
		%ACHIEVEMENTHANDLER._achshow(grave, "GRAVEYARD OF GODS", 1)
	
