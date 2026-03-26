extends TextureButton
var debugtoggled = false


func _on_mouse_entered() -> void:
	var tween = create_tween()
	tween.tween_property(%DebugMenuButton, "modulate", Color("ffffff7a"), 0.075)

func _on_mouse_exited() -> void:
	var tween = create_tween()
	tween.tween_property(%DebugMenuButton, "modulate", Color("ffffff34"), 0.075)

func _on_button_down() -> void:
	%DebugMenuButton.modulate = Color("ffffffff")

func _on_button_up() -> void:
	%DebugMenuButton.modulate = Color("ffffff7a")

func _on_pressed() -> void:
	if debugtoggled == false:
		%DEBUGSETTINGS.show()
		%DebugSettingsBox.show()
		debugtoggled = true
		%debugopensfx.play()
	else:
		%DEBUGSETTINGS.hide()
		%DebugSettingsBox.hide()
		debugtoggled = false
		%debugclosesfx.play()
