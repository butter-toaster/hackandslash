extends Node
var vheartactive = false
var eheartactive = false
var dualheartcombo = false
var empty = preload("res://images/extraheartempty.png")
var vfull = preload("res://images/vampireheart.png")
var efull = preload("res://images/flaskheart.png")

func _ready() -> void:
	if GameManager.drug == true:
		_druggain()
	if GameManager.lifesteal == true and GameManager.flask == true:
		dualheartcombo = true
		%bothhearts.show()
		_elixirheartgain()
	elif GameManager.lifesteal == true or GameManager.flask == true:
		if GameManager.lifesteal == true:
			%vampireheart.show()
		else:
			%elixirheart.show()
			_elixirheartgain()

func _vampireheartgain() -> void:
	if vheartactive == false:
		vheartactive = true
		%vheartgainsfx.play()
		if dualheartcombo == false:
			%vampireheart.get_child(1).texture = vfull
			var glowtween = create_tween()
			glowtween.tween_property(%vampireheart.get_child(0), "modulate", Color("c5a01f00"), 0.6).from(Color("c5a01fa4"))
		else:
			%bothhearts.get_child(3).texture = vfull
			var glowtween = create_tween()
			glowtween.tween_property(%bothhearts.get_child(2), "modulate", Color("c5a01f00"), 0.6).from(Color("c5a01fa4"))
	
func _vampireheartloss() -> void:
	if vheartactive == true:
		vheartactive = false
		%vheartlosesfx.play()
		%Player._playerspecialhit("vhit", 0)
		if dualheartcombo == false:
			%vampireheart.get_child(1).texture = empty
			var glowtween = create_tween()
			glowtween.tween_property(%vampireheart.get_child(0), "modulate", Color("ffffff00"), 0.6).from(Color("090f0f55"))
		else:
			%bothhearts.get_child(3).texture = empty
			var glowtween = create_tween()
			glowtween.tween_property(%bothhearts.get_child(2), "modulate", Color("ffffff00"), 0.6).from(Color("090f0f55"))

func _elixirheartgain() -> void:
	if eheartactive == false:
		eheartactive = true
		%vheartgainsfx.play()
		if dualheartcombo == false:
			%elixirheart.get_child(1).texture = efull
			var glowtween = create_tween()
			glowtween.tween_property(%elixirheart.get_child(0), "modulate", Color("00b6e100"), 0.6).from(Color("00b6e1af"))
		else:
			%bothhearts.get_child(1).texture = efull
			var glowtween = create_tween()
			glowtween.tween_property(%bothhearts.get_child(0), "modulate", Color("00b6e100"), 0.6).from(Color("00b6e1af"))

func _elixirheartloss() -> void:
	if eheartactive == true:
		eheartactive = false
		%vheartlosesfx.play()
		%Player._playerspecialhit("ehit", 0)
		if dualheartcombo == false:
			%elixirheart.get_child(1).texture = empty
			var glowtween = create_tween()
			glowtween.tween_property(%elixirheart.get_child(0), "modulate", Color("ffffff00"), 0.6).from(Color("090f0f55"))
		else:
			%bothhearts.get_child(1).texture = empty
			var glowtween = create_tween()
			glowtween.tween_property(%bothhearts.get_child(0), "modulate", Color("ffffff00"), 0.6).from(Color("090f0f55"))
			
func _elixirsave() -> void:
	var hitvfx = %flasksave
	hitvfx.show()
	var hitvfxtween = create_tween().set_parallel(true)
	hitvfxtween.tween_property(hitvfx, "modulate", Color("ffffff00"), 1)
	hitvfxtween.tween_property(hitvfx, "scale", Vector2(0.6, 0.6), 1)
	%Player._playerheal(5)
	%flasksavesfx.play()

func _druggain() -> void:
	await get_tree().create_timer(2).timeout
	%perkhoversfx.play()
	var t1 = create_tween()
	t1.tween_property(%wonderdrugcontrol, "position:x", 0, 0.18).from(-130).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	
func _drugused() -> void:
	%Player.dopeaspeedbuff = 0.34
	%Player.dopespeedbuff = 56
	%Player.dopecrashdebuff = 0
	
	%doperadiancesprite.show()
	%wddopesfx.play()
	%wddopeambience.play()
	%Player.dopeinvincible = true
	
	var hitvfx = %wddope
	hitvfx.show()
	var hitvfxtween = create_tween().set_parallel(true)
	hitvfxtween.tween_property(hitvfx, "modulate", Color("ffffff00"), 0.2)
	hitvfxtween.tween_property(hitvfx, "scale", Vector2(0.6, 0.6), 0.2)
	var t1 = create_tween()
	t1.tween_property(%wonderdrugcontrol, "position:x", -130, 0.18).from(0).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	
	await get_tree().create_timer(6).timeout
	var dopetween = create_tween()
	dopetween.tween_property(%doperadiancesprite, "modulate", Color("ffffff00"), 1)
	
	await get_tree().create_timer(1.2).timeout
	%Player.dopeaspeedbuff = 0
	%Player.dopespeedbuff = 0
	%Player.dopecrashdebuff = 21
	%Player.dopeinvincible = false
