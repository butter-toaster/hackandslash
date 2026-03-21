extends CanvasLayer

func _perkcinebarsstart() -> void:
	var tween1 = create_tween()
	tween1.tween_property(%bar1, "position:y", 0, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	var tween2 = create_tween()
	tween2.tween_property(%bar2, "position:y", 960, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)

func _perkcinebarsretreat() -> void:
	var tween1 = create_tween()
	tween1.tween_property(%bar1, "position:y", -160, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	var tween2 = create_tween()
	tween2.tween_property(%bar2, "position:y", 1120, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	
