extends Label
var disabled = false


func _modehover() -> void:
	if disabled == false:
		if GameManager.expertmode == false:
			%playhovermode.text = "NORMAL MODE"
		else:
			%playhovermode.text = "EXPERT MODE"
			
		if $"..".has_node("%notsupposedtobehere"):
			%playhovermode.text = "01000101 01000001 01010100 01000101 01001110"
			
		%playhovermode.show()
	
func _modeoffhover() -> void:
	%playhovermode.hide()


func _on_play_button_mouse_entered() -> void:
	_modehover()


func _on_play_button_mouse_exited() -> void:
	_modeoffhover()
