extends Area2D

func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		if GameManager.expertmode == true:
			var tween = create_tween()
			tween.tween_property(%bgmusicbodyexpert, "volume_db", -50, 7)
		else:
			if $"..".name == "Level2":
				var tween = create_tween()
				tween.tween_property(%ambiencesfxplayer, "volume_db", -50, 7)
			else:
				var tween = create_tween()
				tween.tween_property(%bgmusicbody, "volume_db", -50, 7)
	
