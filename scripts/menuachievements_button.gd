extends Button


func _on_mouse_entered() -> void:
	$icon1.modulate = Color.WHITE
	$itemhoversfx.play()
	

func _on_mouse_exited() -> void:
	$icon1.modulate = Color("1f5754")
	

func _on_button_down() -> void:
	$icon1.modulate = Color("668077")
	$selectsfxplayer.play()
	if self.name == "ShopButton":
		%TRANSHANDLER._barsin(0)
		await get_tree().create_timer(1.7).timeout
		%shopentersfx.play()
		%permaperkshop.show()
		%TRANSHANDLER._barsout()
		if GameManager.shoptutcango == true:
			GameManager.shoptutcango = false
			await get_tree().create_timer(1).timeout
			var p = create_tween()
			p.tween_property(%tutcont, "position:x", 650, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	else:
		%achievementslayer.show()

func _on_button_up() -> void:
	if self.name == "ShopButton":
		$icon1.modulate = Color.WHITE
	else:
		$icon1.modulate = Color("1f5754")
