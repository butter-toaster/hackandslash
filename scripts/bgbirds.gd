extends AnimatedSprite2D
var birdsactive = false
var sizerandomizer = [0.8, 1, 1.1]
var speedrandomizer = [0.8, 1, 1.2, 1.4, 1.5]

func _ready() -> void:
	%bgbirds.position.y = -100
	_activatebirds()
	
func _activatebirds() -> void:
	var chance = randi_range(0, 4)
	var size = sizerandomizer.pick_random()
	if chance == 1:
		%bgbirds.position.y = 110
		%bgbirds.scale.y = size
		%bgbirds.scale.x = size
		var tweenin = create_tween()
		tweenin.tween_property(%bgbirds, "modulate", Color.WHITE, 8).from(Color("ffffff00"))
		var tweenpos = create_tween()
		tweenpos.tween_property(%bgbirds, "position:x", -180, 30).from(180)
		await get_tree().create_timer(22).timeout
		var tweenout = create_tween()
		tweenout.tween_property(%bgbirds, "modulate", Color("ffffff00"), 8).from(Color.WHITE)
		await tweenpos.finished
		%bgbirds.position.y = -100
		_activatebirds()
	else:
		await get_tree().create_timer(4).timeout
		_activatebirds()
		
