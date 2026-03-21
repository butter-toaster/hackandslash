extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_pressed)
	self.mouse_entered.connect(_hover)
	

func _pressed() -> void:
	self.get_parent().hide()
	$selectsfxplayer.play()


func _hover() -> void:
	$itemhoversfx.play()
