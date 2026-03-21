extends HSlider

@warning_ignore("shadowed_variable_base_class")
func _on_value_changed(value: float) -> void:
	%mastervolumepercent.text = str(int(value)) + "%"
	var musicset = (-50 + (0.5 * value))
	AudioServer.set_bus_volume_db(0, musicset)
