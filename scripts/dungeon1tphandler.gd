extends Node2D
var pitchrandomizer = [0, 0.25, 0.5, 1]
var atdoorstep = false
var isinside = false
var canpress = true
@onready var dungeondoor = %entertppoint_d1
@onready var outsidedoor = %exittppoint_d1
@onready var dungeonroomcam = %dungeoncam1

func _ready() -> void:
	self.get_node("doortrigger").body_entered.connect(_doorentered)
	self.get_node("doortrigger").body_exited.connect(_doorexited)

func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_W) and atdoorstep == true and canpress == true:
			canpress = false
			var pitchresult = pitchrandomizer.pick_random()
			%doorsfx.pitch_scale = 1 + (0.15 * pitchresult)
			%doorsfx.play()
			atdoorstep = false
			if isinside == false:
				if GameManager.blindness == false:
					%playerlight.enabled = true
					%dungeonshader.enabled = true
				%PlayerCamera.enabled = false
				dungeonroomcam.enabled = true
				%Player.global_position = dungeondoor.global_position
				isinside = true
				await get_tree().create_timer(0.3).timeout
				canpress = true
				return
			if isinside == true:
				if GameManager.blindness == false:
					%playerlight.enabled = false
					%dungeonshader.enabled = false
				%PlayerCamera.enabled = true
				dungeonroomcam.enabled = false
				%Player.global_position = outsidedoor.global_position
				isinside = false
				await get_tree().create_timer(0.3).timeout
				canpress = true
				return

func _doorentered(body: Node2D) -> void:
	if body.name == "Player":
		$prompt.modulate = Color("ffffff00")
		var colortween = create_tween()
		colortween.tween_property($prompt, "modulate", Color.WHITE, 0.20)
		atdoorstep = true

func _doorexited(body: Node2D) -> void:
	if body.name == "Player":
		$prompt.modulate = Color("ffffffff")
		var colortween = create_tween()
		colortween.tween_property($prompt, "modulate", Color("ffffff00"), 0.20)
		atdoorstep = false
