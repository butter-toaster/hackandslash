extends Button

func _ready() -> void:
	self.mouse_entered.connect(_hover)
	
func _on_pressed() -> void:
	var tween = create_tween()
	tween.tween_property(%SETTINGS, "position:y", 0, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
	var tween2 = create_tween()
	
	%overlaydarkening.show()
	tween2.tween_property(%overlaydarkening, "modulate", Color.WHITE, 0.2)
	
	$"..".settingsopen = true
	$selectsfxplayer.play()
func _hover() -> void:
	$itemhoversfx.play()
