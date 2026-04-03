extends Node2D
var canfx = true


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.name == "goofyplayer" and canfx == true:
		canfx = false
		%youwin.show()
		%bgmusic.stream_paused = true
		var chance = randi_range(3, 5)
		if chance == 5:
			%winsfx2.play()
		else:
			%winsfx1.play()
		var t = create_tween()
		t.tween_property(%hiyah, "position:y", 110, 0.2).from(150).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
		await t.finished
		var x = create_tween()
		x.tween_property(%hiyah, "position:y", 150, 0.2).from(110).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
