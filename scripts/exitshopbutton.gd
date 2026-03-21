extends Button


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.pressed.connect(_pressed)
	self.mouse_entered.connect(_hover)
	

func _pressed() -> void:
	%TRANSHANDLER._barsin(0)
	$selectsfxplayer.play()
	await get_tree().create_timer(1.7).timeout
	%permaperkshop.hide()
	%TRANSHANDLER._barsout()

func _hover() -> void:
	$itemhoversfx.play()
