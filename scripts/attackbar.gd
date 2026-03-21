extends ProgressBar
@onready var atimer = $"../attackwindow"
@onready var attackbar = %attackbar
var tweentime = 0.85

func _drainbar() -> void:
	tweentime = $"../attackwindow".wait_time
	attackbar.value = 100
	
	attackbar.show()
	var tween = create_tween()
	tween.tween_property(attackbar, "value", 0, tweentime)
	
	await get_tree().create_timer(tweentime).timeout
	attackbar.hide()
		
