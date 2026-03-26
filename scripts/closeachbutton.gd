extends Button


func _on_pressed() -> void:
	$selectsfxplayer.play()
	if self.name == "closetutbutton":
		var p = create_tween()
		p.tween_property(%tutcont, "position:x", -100, 0.25).set_trans(Tween.TRANS_SINE)
	else:
		%achievementslayer.hide()
