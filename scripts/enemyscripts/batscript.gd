extends CharacterBody2D
@onready var player = %Player
var speed = 80
var speedstaple = null
var aggroed = false
var pitchrandomizer = [0, 0.25, 0.5, 1]
var sandpaperbonus = 1
var omnipbatslowness = 1
var contact = false

func _ready() -> void:
	if GameManager.sandpaper == true:
		sandpaperbonus = 1.1
	if GameManager.omnipotence == true:
		omnipbatslowness = 0.8
	speed = 80 * GameManager.debugenemyspeedmodifier * omnipbatslowness
	self.speedstaple = speed
	
	%sword.body_entered.connect(_swordcontact)
	%dashsword.body_entered.connect(_swordcontact)
	self.get_node("bathitboxarea").body_entered.connect(_playercontact)
	self.get_node("aggroradius").body_entered.connect(_aggroentered)
	self.get_node("aggroradius").body_exited.connect(_aggroexited)
	

func _physics_process(_delta: float) -> void:
	if aggroed == true:
		await get_tree().create_timer(0.05).timeout
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
		move_and_slide()
		
func _aggroentered(body) -> void:
	if body.name == "Player":
		aggroed = true
		var t = create_tween()
		t.tween_property(self, "speed", speedstaple, 0.33).from(0)
func _aggroexited(body) -> void:
	if body.name == "Player":
		aggroed = false
		
func _swordcontact(body) -> void:
	if body.has_node("BatIdentifier") and body.contact == false:
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
			if body.health == 1:
				body._playerdeath("Bat")
			else:
				if body.health == 2 and $"..".has_node("ExpertMode"):
					body._playerdeath("Bat")
				else:
					if $"..".has_node("ExpertMode"):
						body._playerhit(2)
					else:
						body._playerhit(1)
	
func _death(body) -> void:
	var batself = body
	
	var effect = preload("res://deathparticles.tscn").instantiate()
	var dparticles = effect.find_child("deathparticles")
	
	var deathimg = preload("res://deathimg_bat.tscn").instantiate()
	
	$"../..".add_child(effect)
	effect.global_position.x = batself.global_position.x
	effect.global_position.y = batself.global_position.y + 5
	dparticles.emitting = true
	
	$"../..".add_child(deathimg)
	deathimg.get_node("AnimatedSprite2D").frame = batself.get_node("BatASprite").frame
	deathimg.global_position.x = batself.global_position.x
	deathimg.global_position.y = batself.global_position.y + 5
	
	var coinchance = randi_range(0, 100)
	if (GameManager.chance == true and coinchance <= 40) or (coinchance <= 37):
		var cpitch = randf_range(0.88, 1.12)
		%coinappearsfx.pitch_scale = cpitch
		%coinappearsfx.play()
		
		var coin = preload("res://coinpickup.tscn").instantiate()
		$"../..".call_deferred("add_child", coin)
		coin.global_position = batself.global_position


	var batpitchresult = pitchrandomizer.pick_random()
	%bathit.pitch_scale = (batpitchresult * 0.1) + 1
	%bathit.play()
	

	batself.queue_free()
	%scorecounternode.score += int(200 * GameManager.debugscoremultiplier * GameManager.modemultiplier * sandpaperbonus)
	%scorecounternode._scoreupdate()
	
	%KILLMULTHANDLER._multstart()
	
	if GameManager.onyx == true:
		%Player._onyxstatchanges("kill")
	if GameManager.lifesteal == true:
		%Player._lifestealupdate()
