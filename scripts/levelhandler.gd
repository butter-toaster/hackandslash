extends Node
var jfacetexture = preload("res://images/julien2.png")
var jhurtsfx = preload("res://sfx/julienhitsfx2.mp3")
var jdeathsfx = preload("res://sfx/juliendeathsfx2.mp3")
var jskadoosh = preload("res://sfx/skadooshsfx.mp3")
var slot1tip = null
var slot2tip = null
var slot3tip = null
var slot4tip = null
var slot5tip = null



var noloserkills = true
var nolevelscore = true

func _ready() -> void:
	noloserkills = true
	nolevelscore = true
	%bar3.show()
	%bar4.show()
	
	var bus_index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(bus_index, -80)
		
	
	if GameManager.juliensface == true:
		%playersprite.texture = jfacetexture
		%playersprite.scale.x = 0.05
		%playersprite.scale.y = 0.05
		
		%hurtsfxplayer.stream = jhurtsfx
		%hurtsfxplayer.pitch_scale = 0.8
		%hurtsfxplayer.volume_db = -8
		
		%deathtollplayer.stream = jdeathsfx
		%deathtollplayer.pitch_scale = 0.5
		%deathtollplayer.volume_db = -4
		
		%attacksfxplayer.stream = jskadoosh
		%attacksfxplayer.volume_db = 6.7 + 6.7
		
		%jpfp.show()
	if GameManager.blindness == true:
		%kellershader.visible = true
		%kellerlight.enabled = true
		if GameManager.expertmode == true:
			%playerlight2.enabled = false
	if GameManager.extrahearts == true and GameManager.expertmode == false:
		get_tree().call_group("extrahearts", "show")
		%eheartbox1.monitoring = true
		%eheartbox1.monitorable = true
		%eheartbox2.monitoring = true
		%eheartbox2.monitorable = true
		%eheartbox3.monitoring = true
		%eheartbox3.monitorable = true
	if GameManager.extraperkcoins == true:
		get_tree().call_group("extraperks", "show")
		if $"..".has_node("%trolleyendedsfx") or $"..".name == "Level3":
			%eperkbox1.monitoring = true
			%eperkbox1.monitorable = true
		else:
			%eperkbox1.monitoring = true
			%eperkbox1.monitorable = true
			%eperkbox2.monitoring = true
			%eperkbox2.monitorable = true
			%eperkbox3.monitoring = true
			%eperkbox3.monitorable = true
			%eperkbox4.monitoring = true
			%eperkbox4.monitorable = true
	

	await get_tree().create_timer(1).timeout
	AudioServer.set_bus_volume_db(bus_index, 0)
	%TRANSHANDLER._barsout()
	
	if GameManager.tutorialcango == true:
		GameManager.tutorialcango = false
		await get_tree().create_timer(1.5).timeout
		var p = create_tween()
		p.tween_property(%tutcont, "position:x", 650, 0.3).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
