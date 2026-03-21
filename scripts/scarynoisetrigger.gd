extends Area2D
var cantrigger = true
var depressed = preload("res://images/protagonist_depressed.png")


func _on_body_entered(body: Node2D) -> void:
	if body.name == "Player" and cantrigger == true:
		cantrigger = false
		%doorsfx.play()
		await get_tree().create_timer(2).timeout
		%playersprite.texture = depressed
		var tweenmusic = create_tween()
		tweenmusic.tween_property(%ambiencesfxplayer, "pitch_scale", 0.79, 4)
		await get_tree().create_timer(4).timeout
		var tweenin = create_tween()
		tweenin.tween_property(%somebody, "modulate", Color.WHITE, 2)
		await get_tree().create_timer(5).timeout
		var tweenout = create_tween()
		tweenout.tween_property(%somebody, "modulate", Color("ffffff00"), 2)
		await get_tree().create_timer(25).timeout
		%entityhandler._arrive()
