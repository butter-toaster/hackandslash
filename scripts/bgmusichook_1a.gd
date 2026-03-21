extends AudioStreamPlayer


func _ready() -> void:
	self.play()
	
func _on_finished() -> void:
	%BGMUSIC_HANDLER._kickstartbgloop()
