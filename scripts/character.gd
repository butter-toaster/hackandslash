extends CharacterBody2D


var basedashbonus = 0
var MODIFIEDSPEED = 140
var SPEED = 140
var ATTACKSPEED = 0.6
const JUMP_VELOCITY = -360.0
var attackcooldown = true
var dashcooldown = true
var pitchrandomizer = [0, 1, 2, 3, 4, 5]
var health = 3
var hearttexture = preload("res://images/heart.png")
var brokenhearttexture = preload("res://images/heartbroken.png")
var deathparticlescene = preload("res://playerdeathparticles.tscn").instantiate()
@onready var dparticles = deathparticlescene.find_child("playerparticles")
@onready var dashbar = %DashBar
var deathmovementlock = false
var dashishappening = false
var dashprogress = 0
var dashperkactive = false
var dashiframes = false
var dashjustended = false
var invincible = false
var trolleyjumplock = false

var dashfactor = 0
var hermesdashbonus = 0
var swiftnessfactor = 0
var quickdrawfactor = 0

var onyxspeedbuff = 0
var onyxaspeedbuff = 0
var onyxspeeddebuff = 0
var onyxaspeeddebuff = 0
var chancespeedbuff = 0
var chanceaspeedbuff = 0
var badluckmercy = 0
var zeusspeedbuff = 0
var zeusaspeedbuff = 0
var zeusspeeddebuff = 0
var omnipotenceaspeeddebuff = 0

var lifestealkills = 0
var flaskmercy = true
var flaskasdebuff = 0
var sandpaperasbuff = 0
var currentrapierdirection = null
var rapierasbuff = 0
var wdcantake = true
var dopeinvincible = false
var dopeaspeedbuff = 0
var dopespeedbuff = 0
var dopecrashdebuff = 0
var guideswordhits = 0
var guidespeeddebuff = 0
var guideaspeedbuff = 0
var guideheavyattack = false

func _ready() -> void:
	$spawnsfxplayer.play()
	if GameManager.chance == true:
		_chancecycle()
	if GameManager.flask == true:
		flaskasdebuff = 0.085
	if GameManager.sandpaper == true:
		sandpaperasbuff = 0.0425
	if GameManager.rapier == true:
		rapierasbuff = 0.0425
	if GameManager.guide == true:
		guidespeeddebuff = 14
		guideaspeedbuff = 0.0595
	if GameManager.omnipotence == true:
		omnipotenceaspeeddebuff = 0.1275
	invincible = GameManager.invulnerability
	_basestatcalculations()
	
	await get_tree().create_timer(0.05).timeout
	%PlayerCamera.position_smoothing_enabled = true

func _basestatcalculations() -> void:
	if dashishappening == true:
		basedashbonus = 300
		hermesdashbonus = dashfactor
	else:
		basedashbonus = 0
		hermesdashbonus = 0
		
	MODIFIEDSPEED = (140 * GameManager.debugplayerspeedmodifier) + (GameManager.onyxperma_speed * 140) + basedashbonus + swiftnessfactor + hermesdashbonus + dopespeedbuff - dopecrashdebuff  - guidespeeddebuff + onyxspeedbuff - onyxspeeddebuff + chancespeedbuff + zeusspeedbuff - zeusspeeddebuff + swiftnessfactor
	ATTACKSPEED =  0.6 - (GameManager.onyxperma_aspeed * 0.85) + flaskasdebuff - sandpaperasbuff - rapierasbuff - dopeaspeedbuff - guideaspeedbuff - onyxaspeedbuff + onyxaspeeddebuff - chanceaspeedbuff - zeusaspeedbuff + omnipotenceaspeeddebuff - quickdrawfactor
	if ATTACKSPEED <= 0.25:
		ATTACKSPEED = 0.25
		
	SPEED = MODIFIEDSPEED
	%attackwindow.wait_time = ATTACKSPEED
	await %statcalctimer.timeout
	_basestatcalculations()

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("attack") and attackcooldown == true:
		attackcooldown = false
		%attackbar._drainbar()
		var attackpitchresult = pitchrandomizer.pick_random()
		$attacksfxplayer.pitch_scale = (attackpitchresult * 0.1) + 1
		
		if GameManager.rapier == true:
			_rapierswordupdate()
		guideswordhits += 1
		if GameManager.guide == true:
			if guideswordhits < 3:
				_guideswordupdate("normal")
				%attacksfxplayer.volume_db = -3.826
			else: 
				guideswordhits = 0
				_guideswordupdate("heavy")
				%attacksfxplayer.volume_db = 6
		$attacksfxplayer.play()
		$sword/AnimatedSprite2D.play()
		$sword/AnimatedSprite2D2.play()
		_attackactivate(true)
		$attackwindow.start()
		$actualattack.start()
	if Input.is_action_just_pressed("dope") and wdcantake == true and GameManager.drug == true:
		wdcantake = false
		%PERMAPERKHANDLER._drugused()

func _process(_delta: float) -> void:
	if dashishappening == true:
		var dashafterimage1 = preload("res://afterimageprot.tscn").instantiate()
		$"..".add_child(dashafterimage1)
		dashafterimage1.global_position = self.global_position
	if dashperkactive == true:
		if dashishappening == false:
			$dashsword.monitoring = false
			if dashjustended == true:
				dashiframes = true
			else:
				dashiframes = false
		else:
			$dashsword.monitoring = true
			dashiframes = true

		
func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta
	if Input.is_action_just_pressed("jump") and is_on_floor() and trolleyjumplock == false:
		var rjpitchresult = pitchrandomizer.pick_random()
		$jumpsfxplayer.pitch_scale = (rjpitchresult * 0.1) + 1
		$jumpsfxplayer.play()
		velocity.y = JUMP_VELOCITY
	var direction := Input.get_axis("left", "right")
	if direction and (deathmovementlock != true):
		velocity.x = direction * SPEED
		currentrapierdirection = direction
		if Input.is_action_just_pressed("dash") and dashcooldown == true:
			dashcooldown = false
			dashishappening = true
			
			_dashdrain()
			$dashsfxplayer.play()
			$dashinterval.start()
			
			%perkblur.material.set_shader_parameter("lod", 0.7)
			var blurtween = create_tween()
			blurtween.tween_property(%perkblur.material, "shader_parameter/lod", 0, 0.15)
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	move_and_slide()
		
func _on_attackwindow_timeout() -> void:
	attackcooldown = true
	guideheavyattack = false

func _on_actualattack_timeout() -> void:
	_attackactivate(false)
	
func _attackactivate(active: bool):
	$sword.monitoring = active
	$sword.monitorable = active

func _dashdrain() -> void:
	dashbar.show()
	dashprogress = 100
	var dashtween = create_tween()
	dashtween.tween_property(dashbar, "value", 0, 1.5)
	await get_tree().create_timer(1.5).timeout
	dashbar.hide()
	dashcooldown = true
	
func _on_dashinterval_timeout() -> void:
	SPEED -= (300 + dashfactor)
	dashishappening = false
	dashjustended = true
	$dashendedinterval.start()
	
func _on_dashendedinterval_timeout() -> void:
	dashjustended = false





func _on_deadzone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		_playerdeath("The Abyss")
	

func _playerheal(amount) -> void:
	health += amount
	modulate = Color("358d62ff")
	var hitcolortween = create_tween()
	hitcolortween.tween_property(self, "modulate", Color.WHITE, 0.55)
	$"../heartsfx".play()
	_healthchangehandler()

func _playerhit(damage) -> void:
	health -= damage
	modulate = Color("e67c82")
	var hitcolortween = create_tween()
	hitcolortween.tween_property(self, "modulate", Color.WHITE, 0.35)
	$hurtsfxplayer.play()
	_healthchangehandler()
	
	%hitradiancesprite.modulate = Color("ffffff36")
	%hitradiancesprite.show()
	var hitvfxtween = create_tween()
	hitvfxtween.tween_property(%hitradiancesprite, "modulate", Color("ffffff00"), 0.15)
	await hitvfxtween.finished
	%hitradiancesprite.hide()
	
	if GameManager.onyx == true:
		_onyxstatchanges("hit")
	if GameManager.flask == true and health == 1 and flaskmercy == true:
		flaskmercy = false
		%PERMAPERKHANDLER._elixirsave()
		
func _playerspecialhit(type, damage) -> void:
	health -= damage
	$hurtsfxplayer.play()
	_healthchangehandler()
	
	var color = null
	var hitvfx = null
	if type == "vhit":
		hitvfx = %hitradiancesprite_v
		color = Color("c5a01fff")
	elif type == "ehit":
		hitvfx = %hitradiancesprite_e
		color = Color("00b6e1ff")
		
	modulate = color
	var hitcolortween = create_tween()
	hitcolortween.tween_property(self, "modulate", Color.WHITE, 0.35)
	hitvfx.modulate = Color("ffffff36")
	
	hitvfx.show()
	var hitvfxtween = create_tween()
	hitvfxtween.tween_property(hitvfx, "modulate", Color("ffffff00"), 0.15)
	await hitvfxtween.finished
	hitvfx.hide()
	
func _playerdeath(enemy) -> void:
	if invincible == false:
		invincible = true
		GameManager.timesdied += 1
		%deathscreen._ondeath(enemy)
		
		if deathparticlescene.get_parent() == null:
			$"..".add_child(deathparticlescene)
		deathparticlescene.global_position = self.global_position
		dparticles.emitting = true
			
		health = 0
		$"../healthbar/HBoxContainer/Heart1/Sprite2D".texture = brokenhearttexture
		$"../healthbar/HBoxContainer/Heart2/Sprite2D".texture = brokenhearttexture
		$"../healthbar/HBoxContainer/Heart3/Sprite2D".texture = brokenhearttexture
			
		deathmovementlock = true
		%deathscreeneffect.show()
		
		self.position.y = 1000
		$deathtollplayer.play()
		
		%hitradiancesprite.modulate = Color("ffffff36")
		%hitradiancesprite.show()
		var hitvfxtween = create_tween()
		hitvfxtween.tween_property(%hitradiancesprite, "modulate", Color("ffffff00"), 0.15)
		
		if GameManager.juliensface == true:
			%julienjumpsprite.show()
			%julienjumpsprite.modulate = Color.WHITE
			var jtween = create_tween()
			jtween.tween_property(%julienjumpsprite, "modulate", Color("ffffff00"), 0.67)
	
func _healthchangehandler() -> void:
	if health >= 3:
		health = 3
		$"../healthbar/HBoxContainer/Heart1/Sprite2D".texture = hearttexture
		$"../healthbar/HBoxContainer/Heart2/Sprite2D".texture = hearttexture
		$"../healthbar/HBoxContainer/Heart3/Sprite2D".texture = hearttexture
	elif health == 2:
		$"../healthbar/HBoxContainer/Heart1/Sprite2D".texture = hearttexture
		$"../healthbar/HBoxContainer/Heart2/Sprite2D".texture = hearttexture
		$"../healthbar/HBoxContainer/Heart3/Sprite2D".texture = brokenhearttexture
	elif health == 1:
		$"../healthbar/HBoxContainer/Heart1/Sprite2D".texture = hearttexture
		$"../healthbar/HBoxContainer/Heart2/Sprite2D".texture = brokenhearttexture
		$"../healthbar/HBoxContainer/Heart3/Sprite2D".texture = brokenhearttexture
	elif health <= 0:
		health = 0
		$"../healthbar/HBoxContainer/Heart1/Sprite2D".texture = brokenhearttexture
		$"../healthbar/HBoxContainer/Heart2/Sprite2D".texture = brokenhearttexture
		$"../healthbar/HBoxContainer/Heart3/Sprite2D".texture = brokenhearttexture
		

func _onyxstatchanges(type) -> void:
	if type == "hit":
		onyxaspeedbuff = 0
		onyxspeedbuff = 0
		onyxaspeeddebuff += 0.034
		onyxspeeddebuff += 5.6
	if type == "kill":
		onyxaspeedbuff += 0.00425
		onyxspeedbuff += 0.7
			
func _chancecycle() -> void:
	await get_tree().create_timer(10).timeout
	var chance = [1, 2]
	var outcome = chance.pick_random()
	if outcome == 1 or badluckmercy == 2:
		chancespeedbuff = 35
		chanceaspeedbuff = 0.2125
		%chance_good.play()
		%chanceparticles.modulate = Color("b4fb00ff")
		%chanceparticles.emitting = true
	else:
		chancespeedbuff = -42
		chanceaspeedbuff = -0.246
		%chance_bad.play()
		%chanceparticles.modulate = Color("a27a91ff")
		%chanceparticles.emitting = true
		
	_chancecycle()

func _lifestealupdate() -> void:
	lifestealkills += 1
	if lifestealkills >= 30:
		if health <= 2:
			_playerheal(1)
		lifestealkills = 0
	var check1 = lifestealkills
	await get_tree().create_timer(15).timeout
	var check2 = lifestealkills
	if check1 == check2:
		if GameManager.trolleyinprogress == true:
			return
		else:
			if health == 1:
				health = 0
				_playerdeath("Bloodthirst")
				GameManager.diedcomedically = true
			else:
				_playerhit(1)
		return
		
func _dodge() -> void:
	%dodgesfx.play()
	
func _rapierswordupdate() -> void:
	if currentrapierdirection >= 0:
		$sword.position.x = 22.5
		$sword.scale.x = 0.75
		$sword/AnimatedSprite2D.position.x = 10
		$sword/AnimatedSprite2D.scale.x = 1.83
		$sword/AnimatedSprite2D2.hide()
		$sword/AnimatedSprite2D.show()
	elif currentrapierdirection <= 0:
		$sword.position.x = -22.5
		$sword.scale.x = 0.75
		$sword/AnimatedSprite2D2.position.x = -10
		$sword/AnimatedSprite2D2.scale.x = 1.83
		$sword/AnimatedSprite2D.hide()
		$sword/AnimatedSprite2D2.show()
		
func _guideswordupdate(type) -> void:
	if type == "heavy":
		$sword.scale.x = 1.4
		$sword.modulate = Color("ebd741ff")
		guideheavyattack = true
	else:
		$sword.scale.x = 1.0
		$sword.modulate = Color("ffffffff")
		guideheavyattack = false
