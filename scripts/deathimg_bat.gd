extends Node2D

func _ready() -> void:
	var fade = create_tween()
	fade.tween_property(self, "modulate", Color("ffffff00"), 0.11)
	await fade.finished
	self.queue_free()
