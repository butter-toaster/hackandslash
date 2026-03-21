extends CharacterBody2D
@onready var player = %Player
var sandpaperbonus = 1
var contact = false

func _ready() -> void:
	if GameManager.sandpaper == true:
		sandpaperbonus = 1.1
	%sword.body_entered.connect(_swordcontact)
	%dashsword.body_entered.connect(_swordcontact)
	self.get_node("daggerdudehitboxarea").body_entered.connect(_playercontact)
		
		
func _swordcontact(body) -> void:
	if body.has_node("DaggerDudeIdentifier") and body.contact == false:
		body.contact = true
		_death(body)

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
			if GameManager.omnipotence == true:
				var chance = [1, 2].pick_random()
				if chance == 1:
					if body.health == 1:
						body._playerdeath("Dagger Dude")
					else:
						body._playerhit(1)
				else:
					if body.health == 1 or body.health == 2:
						body._playerdeath("Dagger Dude")
					else:
						body._playerhit(2)
			else:
				if body.health == 1 or body.health == 2:
					body._playerdeath("Dagger Dude")
				else:
					body._playerhit(2)

func _death(body) -> void:
	var dagself = body
	
	var effect = preload("res://deathparticles.tscn").instantiate()
	var dparticles = effect.find_child("deathparticles")
	
	var deathimg = preload("res://deathimg_daggerdude.tscn").instantiate()
			
	$"../..".add_child(effect)
	effect.global_position.y = dagself.global_position.y
	effect.global_position.x = dagself.global_position.x + 10
	dparticles.emitting = true
	
	$"../..".add_child(deathimg)
	deathimg.get_node("AnimatedSprite2D").frame = dagself.get_child(1).frame
	deathimg.global_position.y = dagself.global_position.y
	deathimg.global_position.x = dagself.global_position.x

	var coinchance = randi_range(0, 100)
	if (GameManager.chance == true and coinchance <= 81) or (coinchance <= 78):
		var cpitch = randf_range(0.88, 1.12)
		%coinappearsfx.pitch_scale = cpitch
		%coinappearsfx.play()
		
		var coin = preload("res://coinpickup.tscn").instantiate()
		$"../..".call_deferred("add_child", coin)
		coin.global_position = dagself.global_position
	
	%daggerdeath.play()
	
	dagself.queue_free()
	%scorecounternode.score += int(350 * GameManager.debugscoremultiplier * GameManager.modemultiplier * sandpaperbonus)
	%scorecounternode._scoreupdate()
	%KILLMULTHANDLER._multstart()	
	
	if GameManager.onyx == true:
		%Player._onyxstatchanges("kill")
	if GameManager.lifesteal == true:
		%Player._lifestealupdate()
