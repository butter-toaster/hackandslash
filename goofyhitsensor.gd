extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.body_entered.connect(_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _hit(body) -> void:
	if body.name == "goofyplayer":
		body.deathlock = true
		%deathsfx.play()
		%youlose.show()
		%bgmusic.stream_paused = true
