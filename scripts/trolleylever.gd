extends Node2D
var lightactivated = preload("res://images/trolley_onlight.png")

func _on_clickregion_input_event(_viewport: Node, _event: InputEvent, _shape_idx: int) -> void:
	if Input.is_action_just_pressed("attack"):
		$trolleyanimation.play()
		%leverpullsfx.play()
		GameManager.trolleycango = true
		get_tree().call_group("trolleylights", "set_texture", lightactivated)
		if GameManager.expertmode == true:
			get_tree().call_group("trolleylightlights", "set_color", Color("00f929"))
		
		$clickregion.queue_free()
