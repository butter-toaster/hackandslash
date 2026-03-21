extends Button
var loadtimerandom = [3, 3.5, 4, 5]

func _ready() -> void:
	self.button_down.connect(_bpressed)
	self.mouse_entered.connect(_mousehover)
	self.mouse_exited.connect(_mouseoff)

func _bpressed() -> void:
	if $"../..".has_node("justanothermeal"):
		pass
	else:
		%Player.deathmovementlock = true
	%TRANSHANDLER._barsin(1)
	%buttonpressedsfx.play()
	var time = loadtimerandom.pick_random()
	await get_tree().create_timer(time).timeout
	if self.name == "returnbutton" or GameManager.haswon == true or $"../..".has_node("%justanothermeal"):
		get_tree().change_scene_to_file("res://menu_postwin.tscn")
	else:
		get_tree().change_scene_to_file("res://menu.tscn")
		
func _mousehover() -> void:
	if self.name == "mainmenubutton":
		var tween = create_tween()
		tween.tween_property(self, "position:x", 741, 0.2).from(731).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	
	%perkhoversfx.play()
	
func _mouseoff() -> void:
	if self.name == "mainmenubutton":
		var tween = create_tween()
		tween.tween_property(self, "position:x", 731, 0.2).from(741).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
