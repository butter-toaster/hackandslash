extends Node
var movetween = null
var progtween = null
var mult = 0
var broomicon = preload("res://images/monsterbroom.png")

func _multstart() -> void:
	mult += 1
	
	
	if GameManager.zeus == true:
		var pitchrandomizer = [0.7, 0.8, 0.9, 1, 1.1, 1.2, 1.3]
		%chargegainsfx.pitch_scale = pitchrandomizer.pick_random()
		%chargegainsfx.play()
		
		%electricalcharge.show()
		%Player.zeusspeedbuff += 1.4
		%Player.zeusaspeedbuff += 0.0085
	if mult >= 50 and GameManager.broom == false:
		GameManager.broom = true
		%ACHIEVEMENTHANDLER._achactivate(%broom)
		%ACHIEVEMENTHANDLER._achshow(broomicon, "MONSTER BROOM", 1)
	if mult == 30 and GameManager.lifesteal == true:
		%PERMAPERKHANDLER._vampireheartgain()
	if mult == 30 and GameManager.onyx == true:
		GameManager.onyxperma_aspeed += 0.005
		GameManager.onyxperma_speed += 0.005
		%achunlockedsfx.play()
		
	_multupdate(mult)
	if %killmultnode.modulate.r < 1:
		%killmultnode.modulate.r += 0.005
	if %killmultnode.modulate.g > 0:
		%killmultnode.modulate.g -= 0.005
	if %killmultnode.modulate.b > 0:
		%killmultnode.modulate.g -= 0.003
		
	
	if movetween != null:
		movetween = create_tween()
		movetween.tween_property(%killmultnode, "position:x", 0, 0.18).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).from(-20)
	if progtween != null:
		progtween.kill()
	
	movetween = create_tween()
	movetween.tween_property(%killmultnode, "position:x", 0, 0.18).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	
	progtween = create_tween()
	progtween.tween_property(%multprogress, "value", 0, 4.5).from(100)
	
	await progtween.finished
	_multended()
	
func _multended() -> void:
	%killmultnode.modulate = Color("d3d7d7")
	movetween.kill()
	progtween.kill()
	movetween = null
	progtween = null
	mult = 0
	_multupdate(mult)
	var movetween2 = create_tween()
	movetween2.tween_property(%killmultnode, "position:x", -300, 0.18).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	if GameManager.zeus == true:
		var pitchrandomizer = [0.7, 0.8, 0.9, 1, 1.1, 1.2, 1.3]
		%chargelosesfx.pitch_scale = pitchrandomizer.pick_random()
		%chargelosesfx.play()
		
		%Player.zeusspeedbuff = 0
		%Player.zeusaspeedbuff = 0
		%Player.zeusspeeddebuff = 2.8
		if %Player.health == 1:
			%Player._playerdeath("Burnout")
			GameManager.diedcomedically = true
		else:
			%Player._playerhit(1)
	
func _multupdate(value) -> void:
	%multlabel.text = str(value) + "x KILLS"
