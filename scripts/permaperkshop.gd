extends CanvasLayer
var currentsection = "sword"
var canscroll = true
var pitchrandomizer = [0.96, 1, 1.04]

func _ready() -> void:
	%balance.text = "%03d" % GameManager.coinamount

func _scroll(fadeout, fadein) -> void:
	var pitch = pitchrandomizer.pick_random()
	%shopscrollsfx.pitch_scale = pitch * 0.5
	%shopscrollsfx.play()
	var t1 = create_tween()
	t1.tween_property(fadeout, "modulate", Color("ffffff00"), 0.2)
	var t2 = create_tween()
	t2.tween_property(fadein, "modulate", Color.WHITE, 0.2)

func _on_charm_options_gui_input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("scrollup") and canscroll == true and currentsection != "sword":
		canscroll = false
		if currentsection == "charm":
			currentsection = "shield"
			%charm_options.show()
			%defense_options.show()
			var tweenout = create_tween().set_parallel(true)
			tweenout.tween_property(%charm_options, "position:y", 20, 0.15).from(0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			tweenout.tween_property(%charm_options, "modulate", Color("ffffff00"), 0.15).from(Color("ffffffff")).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			var tweenin = create_tween().set_parallel(true)
			tweenin.tween_property(%defense_options, "position:y", 0, 0.15).from(-20).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			tweenin.tween_property(%defense_options, "modulate", Color("ffffffff"), 0.15).from(Color("ffffff00")).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			await tweenout.finished
			%charm_options.hide()
			
			_scroll(%scrollbartalisman, %scrollbarshield)
			await get_tree().create_timer(0.15).timeout
			canscroll = true
			
		else:
			currentsection = "sword"
			%attack_options.show()
			%defense_options.show()
			var tweenout = create_tween().set_parallel(true)
			tweenout.tween_property(%defense_options, "position:y", 20, 0.15).from(0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			tweenout.tween_property(%defense_options, "modulate", Color("ffffff00"), 0.15).from(Color("ffffffff")).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			var tweenin = create_tween().set_parallel(true)
			tweenin.tween_property(%attack_options, "position:y", 0, 0.15).from(-20).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			tweenin.tween_property(%attack_options, "modulate", Color("ffffffff"), 0.15).from(Color("ffffff00")).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			await tweenout.finished
			%defense_options.hide()
			
			_scroll(%scrollbarshield, %scrollbarsword)
			await get_tree().create_timer(0.15).timeout
			canscroll = true
			
	elif Input.is_action_just_pressed("scrolldown") and canscroll == true and currentsection != "charm":
		canscroll = false
		if currentsection == "sword":
			currentsection = "shield"
			%attack_options.show()
			%defense_options.show()
			var tweenout = create_tween().set_parallel(true)
			tweenout.tween_property(%attack_options, "position:y", -20, 0.15).from(0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			tweenout.tween_property(%attack_options, "modulate", Color("ffffff00"), 0.15).from(Color("ffffffff")).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			var tweenin = create_tween().set_parallel(true)
			tweenin.tween_property(%defense_options, "position:y", 0, 0.15).from(20).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			tweenin.tween_property(%defense_options, "modulate", Color("ffffffff"), 0.15).from(Color("ffffff00")).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			await tweenout.finished
			%attack_options.hide()

			_scroll(%scrollbarsword, %scrollbarshield)
			await get_tree().create_timer(0.15).timeout
			canscroll = true
			
		else:
			currentsection = "charm"
			%charm_options.show()
			%defense_options.show()
			var tweenout = create_tween().set_parallel(true)
			tweenout.tween_property(%defense_options, "position:y", -20, 0.15).from(0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			tweenout.tween_property(%defense_options, "modulate", Color("ffffff00"), 0.15).from(Color("ffffffff")).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			var tweenin = create_tween().set_parallel(true)
			tweenin.tween_property(%charm_options, "position:y", 0, 0.15).from(20).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			tweenin.tween_property(%charm_options, "modulate", Color("ffffffff"), 0.15).from(Color("ffffff00")).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			await tweenout.finished
			%defense_options.hide()
			
			_scroll(%scrollbarshield, %scrollbartalisman)
			await get_tree().create_timer(0.15).timeout
			canscroll = true
