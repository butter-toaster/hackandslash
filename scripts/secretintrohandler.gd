extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	await get_tree().create_timer(1).timeout
	var tween = create_tween()
	tween.tween_property(%Fade, "modulate", Color("ffffff00"), 5)
