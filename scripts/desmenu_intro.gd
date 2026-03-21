extends Node
@onready var fade = %Fade2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	fade.modulate = Color.BLACK
	await get_tree().create_timer(3).timeout
	%menutheme.play()
	var tweenfade = create_tween()
	tweenfade.tween_property(fade, "modulate", Color("ffffff00"), 3)
	await get_tree().create_timer(2).timeout
	%Fade2.mouse_filter = Control.MOUSE_FILTER_IGNORE
	
