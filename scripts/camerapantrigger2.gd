extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$"../Player/PlayerCamera".enabled = false
		$"../Player/PlayerCamera".position_smoothing_enabled = false
		$"../perkroomcamera2".enabled = true
