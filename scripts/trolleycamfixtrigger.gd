extends Node2D

func _on_camfixtrigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var trolley = GameManager.trolleyinquestion
		trolley.get_node("trolleycamera").enabled = false
		%PlayerCamera.position_smoothing_enabled = false
		%PlayerCamera.enabled = true
		
		await get_tree().create_timer(0.05).timeout
		%PlayerCamera.position_smoothing_enabled = true
		
		self.queue_free()
