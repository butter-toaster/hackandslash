extends CharacterBody2D

var dashfactor = 0
var movementfactor = 0
var SPEED = 100
const JUMP_VELOCITY = -360.0
var pitchrandomizer = [0, 1, 2, 3, 4, 5]
var deathparticlescene = preload("res://playerdeathparticles.tscn").instantiate()
@onready var dparticles = deathparticlescene.find_child("playerparticles")
@onready var dashbar = $"../dashbar/DashBar"
var deathmovementlock = false
var dashishappening = false
var dashcooldown = true
var dashprogress = 0
var canstartdrain = false
var dashperkactive = false
var dashiframes = false
var dashjustended = false
var overflowperkcoin = false

func _ready() -> void:
	await get_tree().create_timer(0.8).timeout
	%PlayerCamera.position_smoothing_enabled = true


func _process(_delta: float) -> void:
	var rjpitchresult = pitchrandomizer.pick_random()
	$jumpsfxplayer.pitch_scale = (rjpitchresult * 0.1) + 1
		
	if (dashishappening == true):
		var dashafterimage1 = preload("res://afterimageprot.tscn").instantiate()
		$"..".add_child(dashafterimage1)
		dashafterimage1.global_position = self.global_position
		$dashsword.monitoring = true
		dashiframes = true
	if (dashjustended == true) and (dashperkactive == true):
		dashiframes = true
	if dashjustended == false:
		dashiframes = false
	
	if dashishappening == false:
		$dashsword.monitoring = false
	
	if (canstartdrain == true) and (dashprogress > 0):
		dashprogress -= 1.5
		if (dashprogress == 0) or (dashprogress < 0):
			dashprogress = 0
			canstartdrain = false
			dashcooldown = true
			
		

		
func _physics_process(delta: float) -> void:
	velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		$jumpsfxplayer.play()
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("left", "right")
	if direction and (deathmovementlock != true):
		velocity.x = direction * (SPEED + movementfactor)
		if Input.is_action_just_pressed("dash") and dashcooldown == true:
			dashishappening = true
			dashprogress = 100
			canstartdrain = true
			$dashsfxplayer.play()
			dashcooldown = false
			SPEED += 200
			SPEED += dashfactor
			$dashinterval.start()
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
func _on_deathtollwait_timeout() -> void:
	get_tree().reload_current_scene()


func _on_deadzone_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$deathscreeneffect.visible = true
		
		$".".position.y = 1000
		$deathtollplayer.play()
		$deathtollwait.start()
		deathmovementlock = true

func _on_dashinterval_timeout() -> void:
	SPEED = 100 + movementfactor
	dashishappening = false
	dashjustended = true
	$dashendedinterval.start()
	

func _on_dashendedinterval_timeout() -> void:
	dashjustended = false
