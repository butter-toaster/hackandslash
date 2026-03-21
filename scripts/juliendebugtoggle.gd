extends CheckButton

func _ready() -> void:
	if GameManager.juliensface == true:
		%julientoggle.button_pressed = true
		%juliendesc.modulate = Color.WHITE

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		%toggleonsfx.play()
		GameManager.juliensface = true
		%juliendesc.modulate = Color.WHITE
	else:
		%toggleoffsfx.play()
		GameManager.juliensface = false
		%juliendesc.modulate = Color("ffffff5d")
