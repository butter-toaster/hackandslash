extends CheckButton

func _ready() -> void:
	if GameManager.extrahearts == true:
		%heartstoggle.button_pressed = true
		%heartsdesc.modulate = Color.WHITE

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		%toggleonsfx.play()
		GameManager.extrahearts = true
		%heartsdesc.modulate = Color.WHITE
	else:
		%toggleoffsfx.play()
		GameManager.extrahearts = false
		%heartsdesc.modulate = Color("ffffff5d")
