extends HSlider

func _ready() -> void:
	self.value = GameManager.debugenemyspeedmodifier * 100

@warning_ignore("shadowed_variable_base_class")
func _on_value_changed(value: float) -> void:
	var input1 = value * 0.01
	GameManager.debugenemyspeedmodifier = input1
	%enemyspeedlabel.text = "ENEMY SPEED: " + str(input1) + "x"
