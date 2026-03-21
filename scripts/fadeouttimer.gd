extends Timer
var randomloadingtime = [3, 4, 5, 6, 7]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var time = randomloadingtime.pick_random()
	$".".wait_time = time
