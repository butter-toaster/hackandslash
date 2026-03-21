extends Node2D
var tactivated = false
var siderandomizer = [1, 2, 3, 13, 12, 23]
var origin = null
var originside = null
var timesattacked = 0
var inbetweentime = 2.31
var lightoff = preload("res://images/trolley_offlight.png")
var attacked = false


func _process(_delta: float) -> void:
	var distance = origin.global_position.x - %Player.global_position.x
	if distance >= 220:
		%Player._playerdeath("The Abyss")
		
func _ready() -> void:
	if GameManager.omnipotence == true:
		siderandomizer = [1, 2, 3, 13, 12, 23, 1, 2, 3, 13, 12, 23, 1, 2, 3]
		timesattacked += 1
		inbetweentime = 3.1
	set_process(false)
		

func _on_trolleychecker_body_entered(body: Node2D) -> void:
	if body.name == "trolleyfloor":
		origin = body.get_parent()
		if origin.tactivated == false and GameManager.trolleycango == true:
			GameManager.trolleyinprogress = true
			GameManager.trolleycango = false
			origin.tactivated = true
			set_process(true)
			
			GameManager.trolleyinquestion = origin
			%Player.trolleyjumplock = true
			var positionx = (origin.global_position.x) + 2352 + 2352
			origin.get_node("trolleycamera").enabled = true
			%PlayerCamera.enabled = false
			%trolleywhistlesfxplayer.play()
			
			await get_tree().create_timer(2).timeout
			var postween = create_tween()
			postween.tween_property(origin, "global_position:x", positionx, 40).set_ease(Tween.EASE_IN_OUT).set_trans(Tween.TRANS_QUAD)
			var sfxtweenin = create_tween()
			sfxtweenin.tween_property(%trolleyambiencesfxplayer, "volume_db", 2, 4).from(-80)
			%trolleyambiencesfxplayer.play()
			
			await get_tree().create_timer(4).timeout
			var musicintween = create_tween()
			musicintween.tween_property(%locustambienceplayer, "volume_db", -6.3, 3.3).from(-40)
			var pursuittween1 = create_tween()
			pursuittween1.tween_property(%horde, "position:x", 300, 8).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			var pursuittween2 = create_tween()
			pursuittween2.tween_property(%hordebg, "position:x", 300, 8).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
			
			await get_tree().create_timer(3).timeout
			_locustattackchance(origin)
			set_process(false)
			
			await get_tree().create_timer(23).timeout
			%Player.trolleyjumplock = false
			var musicouttween = create_tween()
			musicouttween.tween_property(%locustambienceplayer, "volume_db", -80, 20).from(-6.3)
			var sfxtweenout = create_tween()
			sfxtweenout.tween_property(%trolleyambiencesfxplayer, "volume_db", -80, 6).from(2)
			var pursuitawaytween1 = create_tween()
			pursuitawaytween1.tween_property(%horde, "position:x", 0, 4).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
			var pursuitawaytween2 = create_tween()
			pursuitawaytween2.tween_property(%hordebg, "position:x", 0, 4).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_SINE)
			
			await get_tree().create_timer(2.5).timeout
			get_tree().call_group("trolleylights", "set_texture", lightoff)
			if GameManager.expertmode == true:
				$trolleylightlight.color = Color("ed3952")
			origin.get_node("smokeparticles1").emitting = true
			origin.get_node("smokeparticles2").emitting = true
			%trolleyhaltingsfx.play()
			
			await get_tree().create_timer(1).timeout
			var smoke1tween = create_tween()
			smoke1tween.tween_property(origin.get_node("smokeparticles1"), "color", Color(1.0, 1.0, 1.0, 0.0),6)
			var smoke2tween = create_tween()
			smoke2tween.tween_property(origin.get_node("smokeparticles2"), "color", Color(1.0, 1.0, 1.0, 0.0), 6)
			await smoke2tween.finished
			%trolleyendedsfx.play()
			GameManager.trolleyinprogress = false
			
			
@warning_ignore("shadowed_variable")
func _locustattackchance(origin) -> void:
	if origin.timesattacked >= 7:
		return
	else:
		var tweenpos99x = create_tween()
		tweenpos99x.tween_property(%hordeup, "position:x", 700, 1.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC).from(-77)
		var tweenpos99y = create_tween()
		tweenpos99y.tween_property(%hordeup, "position:y", -500, 1.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).from(300)
	await get_tree().create_timer(inbetweentime).timeout
	var chance = siderandomizer.pick_random()
	if chance == 1:
		origin.timesattacked += 1
		_locustattack(origin.get_node("locustattackleft"))
	if chance == 2:
		origin.timesattacked += 1
		_locustattack(origin.get_node("locustattackmiddle"))
	if chance == 3:
		origin.timesattacked += 1
		_locustattack(origin.get_node("locustattackright"))
	if chance == 12:
		origin.timesattacked += 1
		_locustattack(origin.get_node("locustattackleft"))
		await get_tree().create_timer(0.1).timeout
		_locustattack(origin.get_node("locustattackmiddle"))
	if chance == 23:
		origin.timesattacked += 1
		_locustattack(origin.get_node("locustattackmiddle"))
		await get_tree().create_timer(0.1).timeout
		_locustattack(origin.get_node("locustattackright"))
	if chance == 13:
		origin.timesattacked += 1
		_locustattack(origin.get_node("locustattackleft"))
		await get_tree().create_timer(0.1).timeout
		_locustattack(origin.get_node("locustattackright"))
		
	await get_tree().create_timer(0.75).timeout
	_locustattackchance(origin)
		
		
func _locustattack(trolleyside) -> void:
	originside = trolleyside
	var locust = trolleyside.get_child(1)
	var locpostweenin = create_tween()
	locpostweenin.tween_property(locust, "position:y", -10, 0.35).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).from(-100)
	trolleyside.show()
	trolleyside.get_node("warn").show()
	trolleyside.get_node("locustattackwarningsfx").play()
	
	await get_tree().create_timer(0.75).timeout
	
	trolleyside.get_node("warn").hide()
	trolleyside.get_node("locustattacksfx").play()
	trolleyside.get_node("locustdashsfx").play()
	var locpostweenout = create_tween()
	locpostweenout.tween_property(locust, "position:y", 250, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).from(-10)
	await get_tree().create_timer(0.05).timeout
	locust.get_node("attackdetector").monitoring = true
	locust.get_node("attackdetector").monitorable = true
	locust.get_node("attackdetector").body_entered.connect(_attackedplayer)
	await get_tree().create_timer(0.08).timeout
	locust.get_node("attackdetector").monitoring = false
	locust.get_node("attackdetector").monitorable = false
	locust.get_node("attackdetector").body_entered.disconnect(_attackedplayer)
	
	await locpostweenout.finished
	trolleyside.hide()
	locust.position.y = -100
	

func _attackedplayer(body) -> void:
	if body.name == "Player" and body.dashiframes == false and body.invincible == false:
		if body.dopeinvincible == true:
			%dopeblocksfx.play()
			return
		if GameManager.marvel == true:
			var chance = randi_range(1, 10)
			if chance == 5:
				body._dodge()
		elif %PERMAPERKHANDLER.vheartactive == true:
			%PERMAPERKHANDLER._vampireheartloss()
		elif %PERMAPERKHANDLER.eheartactive == true:
			%PERMAPERKHANDLER._elixirheartloss()
		else:
			if body.health == 1:
				body._playerdeath("Locust")
			else:
				body._playerhit(1)
