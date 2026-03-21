extends Button

func _ready() -> void:
	self.mouse_entered.connect(_hover)

func _on_pressed() -> void:
	$"../../mainmenuexittab".visible = false
	$"../../buttonpressedsfx".play()
	
func _hover() -> void:
	%perkhoversfx.play()
