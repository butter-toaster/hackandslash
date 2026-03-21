extends CheckButton

func _ready() -> void:
	if GameManager.extraperkcoins == true:
		%perktoggle.button_pressed = true
		%perkdesc.modulate = Color.WHITE

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		%toggleonsfx.play()
		GameManager.extraperkcoins = true
		%perkdesc.modulate = Color.WHITE
	else:
		%toggleoffsfx.play()
		GameManager.extraperkcoins = true
		%perkdesc.modulate = Color("ffffff5d")
