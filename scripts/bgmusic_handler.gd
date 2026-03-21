extends Node

func _ready() -> void:
	self.get_child(0).play()
		
func _kickstartbgloop() -> void:
	self.get_child(1).play()
