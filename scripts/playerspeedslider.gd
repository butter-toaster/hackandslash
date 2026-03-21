extends HSlider

func _ready() -> void:
	self.value = GameManager.debugplayerspeedmodifier * 100

@warning_ignore("shadowed_variable_base_class")
func _on_value_changed(value: float) -> void:
	var input1 = ((value - 100) * 0.01) + 1
	GameManager.debugplayerspeedmodifier = input1
	%playerspeedlabel.text = "PLAYER SPEED: " + str(input1) + "x"
