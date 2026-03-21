extends Button
var buttoncooldown = true

func _ready() -> void:
	self.mouse_entered.connect(_hover)
			
func _hover() -> void:
	$itemhoversfx.play()
	
func _on_pressed() -> void:
	if $"..".has_node("%notsupposedtobehere"):
		buttoncooldown = false
		$selectsfxplayer.play()
		%playhovermode.hide()
		%playhoverhs.hide()
		%fadeaway.show()
			
		%menutheme.volume_db = -4
		var vfade = create_tween()
		vfade.tween_property(%menutheme, "volume_db", -40, 2)
			
		%Fade.modulate = Color("ffffff00")
		var fade = create_tween()
		fade.tween_property(%Fade, "modulate", Color.BLACK, 0.4)
			
		await get_tree().create_timer(0.1).timeout
			
			
		var animfade = create_tween()
		animfade.tween_property(%loadinganimation, "modulate", Color.WHITE, 0.6)
			
		await get_tree().create_timer(1.4).timeout
		var bus_index = AudioServer.get_bus_index("Music")
		AudioServer.set_bus_volume_db(bus_index, -80)
		
		await get_tree().create_timer(4).timeout
		get_tree().change_scene_to_file("res://level_desolate.scn")
	else:
		$selectsfxplayer.play()
		%levelselect.show()
	
