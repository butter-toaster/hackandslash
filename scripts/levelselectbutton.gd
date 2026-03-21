extends Control
var ontexture1 = preload("res://images/level1thumbnail.png")
var ontexture2 = preload("res://images/level2thumbnail.png")
var offtexture1 = preload("res://images/level1thumbnail_bw.png")
var offtexture2 = preload("res://images/level2thumbnail_bw.png")
var buttoncooldown = true
var destination = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.get_child(0).get_child(1).mouse_entered.connect(_hoveron)
	self.get_child(0).get_child(1).mouse_exited.connect(_hoveroff)
	self.get_child(0).get_child(1).pressed.connect(_selected)
	
func _hoveron() -> void:
	var tweenpos = create_tween()
	tweenpos.tween_property(self, "position:y", -8, 0.1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).from(0)
	%itemhoversfx.play()
	if self.name == "level1":
		self.get_child(0).get_child(0).texture = ontexture1
	else:
		self.get_child(0).get_child(0).texture = ontexture2

func _hoveroff() -> void:
	var tweenpos = create_tween()
	tweenpos.tween_property(self, "position:y", 0, 0.1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).from(-8)
	if self.name == "level1":
		self.get_child(0).get_child(0).texture = offtexture1
	else:
		self.get_child(0).get_child(0).texture = offtexture2

func _selected() -> void:
	if buttoncooldown == true:
		buttoncooldown = false
		if self.name == "level1":
			if GameManager.expertmode == false:
				destination = "res://level_1.tscn"
			else:
				destination = "res://expert_level_1.tscn"
		elif self.name == "level2":
			if GameManager.expertmode == false:
				destination = "res://level_2.tscn"
			else:
				destination = "res://expert_level_2.tscn"
				
		buttoncooldown = false
		$selectsfxplayer.play()
		%playhovermode.hide()
		%playhoverhs.hide()
		%fadeaway.show()
			
		%menutheme.volume_db = -4
		var vfade = create_tween()
		vfade.tween_property(%menutheme, "volume_db", -40, 2)
			
		%Fade.modulate = Color("ffffff00")
		var fade = create_tween()
		fade.tween_property(%Fade, "modulate", Color.BLACK, 0.4)
			
		await get_tree().create_timer(0.1).timeout
			
			
		var animfade = create_tween()
		animfade.tween_property(%loadinganimation, "modulate", Color.WHITE, 0.6)
			
		await get_tree().create_timer(1.4).timeout
		var bus_index = AudioServer.get_bus_index("Music")
		AudioServer.set_bus_volume_db(bus_index, -80)
		
		await get_tree().create_timer(2).timeout
		get_tree().change_scene_to_file(destination)
