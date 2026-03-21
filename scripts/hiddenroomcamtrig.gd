extends Area2D
var uneventicon = preload("res://images/secretroomicon.png")

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		%PlayerCamera.limit_bottom = 380
		if GameManager.uneventful == false:
			GameManager.uneventful = true
			%ACHIEVEMENTHANDLER._achactivate(%uneventful)
			%ACHIEVEMENTHANDLER._achshow(uneventicon, "AN UNEVENTFUL FALL", 1)


func _on_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		%PlayerCamera.limit_bottom = 265
