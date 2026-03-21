extends ProgressBar
@onready var player = $"../../Player"

var progress:
	get:
		return player.dashprogress
			
func _process(_delta: float) -> void:
	$".".value = progress
