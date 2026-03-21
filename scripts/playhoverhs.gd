extends Label
var disabled = false

func _hshover() -> void:
	if $"..".has_node("%notsupposedtobehere"):
		return
	if disabled == false:
		var formattedscore = "HIGHSCORE: " + "%06d" % GameManager.highscore
		%playhoverhs.text = str(formattedscore)
		%playhoverhs.show()
	
func _hsoffhover() -> void:
	%playhoverhs.hide()

func _on_play_button_mouse_entered() -> void:
	_hshover()


func _on_play_button_mouse_exited() -> void:
	_hsoffhover()
