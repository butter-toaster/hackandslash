extends Node2D
var atdoorstep = false



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_W) and atdoorstep == true:
			atdoorstep = false
			%doorsfx.play()
			%finalescreen._introsequence()
			
			


func _on_gatetrigger_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		$prompt.modulate = Color("ffffff00")
		var colortween = create_tween()
		colortween.tween_property($prompt, "modulate", Color.WHITE, 0.20)
		atdoorstep = true


func _on_gatetrigger_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		$prompt.modulate = Color("ffffffff")
		var colortween = create_tween()
		colortween.tween_property($prompt, "modulate", Color("ffffff00"), 0.20)
		atdoorstep = false
