extends HSlider

func _ready() -> void:
	self.value = GameManager.debugscoremultiplier * 100
	
@warning_ignore("shadowed_variable_base_class")
func _on_value_changed(value: float) -> void:
	var input1 = ((value - 100) * 0.01) + 1
	GameManager.debugscoremultiplier = input1
	%scoremultiplierlabel.text = "SCORE MULT: " + str(input1) + "x"
