extends Button

func _ready() -> void:
	self.mouse_entered.connect(_hover)

func _on_pressed() -> void:
	$selectsfxplayer.play()
	%achievementslayer.show()

func _hover() -> void:
	%perkhoversfx.play()
