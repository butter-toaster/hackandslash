extends Button

func _on_pressed() -> void:
	var tween = create_tween()
	tween.tween_property(%SETTINGS, "position:y", 1120, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	var tween2 = create_tween()
	
	tween2.tween_property(%overlaydarkening, "modulate", Color("00000000"), 0.2)
	
	$"../..".settingsopen = false
	$selectsfxplayer.play()
	
	await get_tree().create_timer(0.2).timeout
	%overlaydarkening.hide()
