extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$"../Player/PlayerCamera".enabled = false
		$"../Player/PlayerCamera".position_smoothing_enabled = false
		$"../perkroomcamera".enabled = true

func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		$"../perkroomcamera".enabled = false
		$"../Player/PlayerCamera".enabled = true
		$"../Player/PlayerCamera".position_smoothing_enabled = true
