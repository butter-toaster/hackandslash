extends CheckButton

func _ready() -> void:
	if GameManager.invulnerability == true:
		%invinctoggle.button_pressed = true
		%invincdesc.modulate = Color.WHITE

func _on_toggled(toggled_on: bool) -> void:
	if toggled_on:
		%toggleonsfx.play()
		GameManager.invulnerability = true
		%invincdesc.modulate = Color.WHITE
	else:
		%toggleoffsfx.play()
		GameManager.invulnerability = false
		%invincdesc.modulate = Color("ffffff5d")
