extends Button
var buttoncooldown = true
var bpressed = 0
var activated = false
@onready var secretsfx = %secretsfxplayer

func _process(_delta: float) -> void:
	if activated == false and bpressed == 40:
		buttoncooldown = false
		activated = true
		$fadeouttimer.start()
		$selectsfxplayer.play()
		%playhovermode.hide()
		%playhoverhs.hide()
		%fadeaway.show()
		
		%menutheme.volume_db = -4
		var vfade = create_tween()
		vfade.tween_property(%menutheme, "volume_db", -40, 2)
		
		%Fade.modulate = Color("ffffff00")
		var fade = create_tween()
		fade.tween_property(%Fade, "modulate", Color.BLACK, 0.25)
		
		var animfade = create_tween()
		animfade.tween_property(%loadinganimation, "modulate", Color.WHITE, 0.6)

func _on_pressed() -> void:
	if buttoncooldown == true:
		if bpressed == 39:
			secretsfx.pitch_scale += 1
		bpressed += 1
		secretsfx.pitch_scale += 0.008
		secretsfx.play()


	
func _on_fadeouttimer_timeout() -> void:
	get_tree().change_scene_to_file("res://secret_level.tscn")
