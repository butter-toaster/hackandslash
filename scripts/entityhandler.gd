extends CanvasLayer

func _arrive() -> void:
	var tweenstatic2 = create_tween()
	tweenstatic2.tween_property(%entitysfx, "volume_db", 20, 2.3)
	var tweenstatic3 = create_tween()
	tweenstatic3.tween_property(%entitysfx2, "volume_db", 20, 2.3)
	%entitysfx.play()
	%entitysfx2.play()
	await get_tree().create_timer(2.15).timeout
	var tweenentity = create_tween()
	tweenentity.tween_property(%entity, "position:x", 260, 0.135)
	await get_tree().create_timer(0.14).timeout
	%DirectionalLight2D2.show()
	await get_tree().create_timer(0.01).timeout
	get_tree().change_scene_to_file("res://menu_desolate.tscn")
