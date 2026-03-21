extends Node

func _barsout() -> void:
	var bartweenout3 = create_tween()
	bartweenout3.tween_property(%bar3, "position:x", -720, 0.35).from(0).set_trans(Tween.TRANS_SINE)
	var bartweenout4 = create_tween()
	bartweenout4.tween_property(%bar4, "position:x", 1440, 0.35).from(720).set_trans(Tween.TRANS_SINE)
	
func _barsin(value) -> void:
	var bartweenout3 = create_tween()
	bartweenout3.tween_property(%bar3, "position:x", 0, 0.35).from(-720).set_trans(Tween.TRANS_SINE)
	var bartweenout4 = create_tween()
	bartweenout4.tween_property(%bar4, "position:x", 720, 0.35).from(1440).set_trans(Tween.TRANS_SINE)
	if value == 1:
		await get_tree().create_timer(0.5).timeout
		var t9 = create_tween()
		t9.tween_property(%loadinganimation, "modulate", Color.WHITE,0.5).from(Color("ffffff00"))
