extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.get_child(0).pressed.connect(_clicked)

func _clicked() -> void:
	pass
