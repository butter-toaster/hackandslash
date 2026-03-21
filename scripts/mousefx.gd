extends CanvasLayer

func _process(_delta: float) -> void:
	var mousepos = get_viewport().get_mouse_position()
	%mouseshadow.position = mousepos
