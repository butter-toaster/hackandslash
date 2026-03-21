extends CanvasLayer
var batimg = preload("res://images/batsingle.png")
var dagimg = preload("res://images/daggerdudesingle.png")
var locimg = preload("res://images/locustsprite.png")
var losimg = preload("res://images/loser.png")
var abyssimg = preload("res://images/fate.png")
var bloodimg = preload("res://images/heartbroken.png")
var musicbus = AudioServer.get_bus_index("Music")
var sweeticon = preload("res://images/heartbroken.png")
var desticon = preload("res://images/vampireheart.png")

func _ondeath(enemy) -> void:
	var musictween = create_tween()
	musictween.tween_method(func(value): AudioServer.set_bus_volume_db(musicbus, value), 0, -80.0, 6)
	await get_tree().create_timer(0.8).timeout
	var ydtween = create_tween()
	ydtween.tween_property(%youdied, "position:y", 0, 0.75).from(-400).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
	
	if GameManager.timesdied >= 20 and GameManager.sweet == false:
		GameManager.sweet = true
		$"../ACHIEVEMENTHANDLER"._achactivate(%sweet)
		$"../ACHIEVEMENTHANDLER"._achshow(sweeticon, "SWEET RELEASE", 1)
	elif GameManager.diedcomedically == true and GameManager.selfdest == false:
		GameManager.selfdest = true
		$"../ACHIEVEMENTHANDLER"._achactivate(%selfdest)
		$"../ACHIEVEMENTHANDLER"._achshow(desticon, "SELF DESTRUCTIVE", 1)
	
	if enemy == "Bat":
		%cause.text = str(enemy)
		%causeimg.scale = Vector2(12, 12)
		%causeimg.texture = batimg
	elif enemy == "Dagger Dude":
		%cause.text = str(enemy)
		%causeimg.scale = Vector2(8, 8)
		%causeimg.texture = dagimg
	elif enemy == "Loser":
		%cause.text = str(enemy)
		%causeimg.scale = Vector2(4, 4)
		%causeimg.texture = losimg
	elif enemy == "Locust":
		%cause.text = str(enemy)
		%causeimg.scale = Vector2(4, 4)
		%causeimg.texture = locimg
	elif enemy == "The Abyss":
		%cause.text = str(enemy)
		%causeimg.scale = Vector2(4, 4)
		%causeimg.texture = abyssimg
	elif enemy == "Bloodthirst":
		%cause.text = str(enemy)
		%causeimg.scale = Vector2(4, 4)
		%causeimg.texture = bloodimg
	elif enemy == "Burnout":
		%cause.text = str(enemy)
		%causeimg.scale = Vector2(4, 4)
		%causeimg.texture = bloodimg
		
	var ctween = create_tween()
	ctween.tween_property(%deathcontrolnode, "position:y", 0, 0.75).from(800).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_QUAD)
