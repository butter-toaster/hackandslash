extends Node
var timeelapsed = 0

func _ready() -> void:
	_counter()
	
func _counter() -> void:
	await get_tree().create_timer(1.0).timeout
	timeelapsed += 1
	_counter()
