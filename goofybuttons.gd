extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_presshandler)
	
func _presshandler() -> void:
	if self.name == "retry":
		get_tree().reload_current_scene()
	elif self.name == "quittomenu":
		get_tree().change_scene_to_file("res://stupid.tscn")
