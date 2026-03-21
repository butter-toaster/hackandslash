extends Button
var loadtimerandom = [3, 3.5, 4, 5]


func _ready() -> void:
	self.button_down.connect(_scenereloadseq)
	self.mouse_entered.connect(_mousehover)
	self.mouse_exited.connect(_mouseoff)
	

func _scenereloadseq() -> void:
	%TRANSHANDLER._barsin(1)
	%buttonpressedsfx.play()
	var time = loadtimerandom.pick_random()
	await get_tree().create_timer(time).timeout
	get_tree().reload_current_scene()
	
func _mousehover() -> void:
	var tween = create_tween()
	tween.tween_property(self, "position:x", 741, 0.2).from(731).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
	%perkhoversfx.play()
	
func _mouseoff() -> void:
	var tween = create_tween()
	tween.tween_property(self, "position:x", 731, 0.2).from(741).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
