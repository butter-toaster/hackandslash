extends CheckButton

func _ready() -> void:
	if GameManager.blindness == true:
		%blindtoggle.button_pressed = true
		%blinddesc.modulate = Color.WHITE

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		%toggleonsfx.play()
		GameManager.blindness = true
		%blinddesc.modulate = Color.WHITE
		AudioServer.set_bus_volume_db(0, -500)
	else:
		%toggleoffsfx.play()
		GameManager.blindness = false
		%blinddesc.modulate = Color("ffffff5d")
		AudioServer.set_bus_volume_db(0, 0)
