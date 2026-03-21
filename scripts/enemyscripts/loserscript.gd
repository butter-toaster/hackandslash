extends CharacterBody2D
@onready var player = %Player
var pitchrandomizer = [0, 0.25, 0.5, 1]
var hitsleft = 3
var blinktexture = preload("res://images/loser.png")
var left = preload("res://images/loserleft.png")
var up = preload("res://images/loserup.png")
var right = preload("res://images/loserright.png")
@onready var effect = %loserdeathparticles
@onready var dparticles = %loserdparticles
var eyeopen = false
var specificself = null
var sandpaperbonus = 1
var isdead = false
var newposition = null
var cancontact = true

func _ready() -> void:
	if GameManager.sandpaper == true:
		hitsleft -= 1
		sandpaperbonus = 1.1
	if GameManager.omnipotence == true:
		hitsleft -= 1
		
	%sword.body_entered.connect(_swordcontact)
	%dashsword.body_entered.connect(_swordcontact)
	self.get_node("loserhitbox").body_entered.connect(_playercontact)

func _process(_delta: float) -> void:
	var constdistance = player.global_position.x - self.global_position.x
	if eyeopen == true:
		if constdistance < -16 or constdistance == -16:
			$losersprite.texture = left
		if (constdistance > -16) and (constdistance < 16):
			$losersprite.texture = up
		if constdistance > 16 or constdistance == 16:
			$losersprite.texture = right


func _swordcontact(body) -> void:
	if body.has_node("LoserIdentifier") and body.cancontact == true:
		body.cancontact = false
		_hit(body)

func _playercontact(body) -> void:
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
				body._playerdeath("Loser")
			else:
				body._playerhit(1)


func _hitfx() -> void:
	var spritecolor = specificself.find_child("losersprite")
	spritecolor.modulate = Color("e67c82")
	var hitcolortween = create_tween()
	hitcolortween.tween_property(spritecolor, "modulate", Color("a4d2e2"), 0.35)
	var pitchresult = pitchrandomizer.pick_random()
	%loserhitsfx.pitch_scale = (pitchresult * 0.1) + 1
	%loserhitsfx.play()

func _hit(body) -> void:
	var loserself = body
	specificself = loserself
	var distance = player.global_position.x - specificself.global_position.x
	loserself.hitsleft -= 1
	if %Player.guideheavyattack == true:
		loserself.hitsleft -= 1
	if loserself.eyeopen == false:
		loserself.eyeopen = true
		_blink(loserself)
	if loserself.hitsleft <= 0:
		var deathimg = preload("res://deathimg_loser.tscn").instantiate()
		$"../..".add_child(deathimg)
		deathimg.global_position.x = loserself.global_position.x
		deathimg.global_position.y = loserself.global_position.y
			
		effect.global_position = loserself.global_position
		dparticles.emitting = true
		
		%loserdeath.play()
		
		var coinchance = randi_range(0, 100)
		if (GameManager.chance == true and coinchance <= 100) or (coinchance <= 97):
			var cpitch = randf_range(0.88, 1.12)
			%coinappearsfx.pitch_scale = cpitch
			%coinappearsfx.play()
			
			var coin = preload("res://coinpickup.tscn").instantiate()
			$"../..".call_deferred("add_child", coin)
			coin.global_position = loserself.global_position
			
		loserself.isdead = true
		%scorecounternode.score += int(420 * GameManager.debugscoremultiplier * GameManager.modemultiplier * sandpaperbonus)
		%scorecounternode._scoreupdate()
		%KILLMULTHANDLER._multstart()
		%LEVELHANDLER.noloserkills = false
		
		if GameManager.onyx == true:
			%Player._onyxstatchanges("kill")
		if GameManager.lifesteal == true:
			%Player._lifestealupdate()
		
		if is_instance_valid(loserself):
			loserself.queue_free()
			return
		else:
			return

		
	if distance > 0:
		newposition = loserself.global_position.x - 40
	if distance < 0:
		newposition = loserself.global_position.x + 40
	var tween = create_tween()
	tween.tween_property(loserself, "global_position:x", newposition, 0.1).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	_hitfx()
	await tween.finished
	if is_instance_valid(loserself):
		loserself.cancontact = true
	else:
		return
		
func _blink(loserself) -> void:
	var time = randi_range(1, 6)
	if is_instance_valid(get_tree()):
		await get_tree().create_timer(time).timeout
	else:
		return
	if is_instance_valid(loserself):
		if loserself.isdead == false:
			loserself.set_process(false)
			loserself.get_node("losersprite").texture = blinktexture
	else:
		return
	if is_instance_valid(get_tree()):
		await get_tree().create_timer(0.15).timeout
	else:
		return
	if is_instance_valid(loserself):
		loserself.set_process(true)
		_blink(loserself)
	else:
		return
