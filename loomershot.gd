extends Node2D
var canhit = true

func _ready() -> void:
	var p = randf_range(-0.15, 0.15)
	$loomershoot.play()
	$loomershoot.pitch_scale = 2 + p
	var posy = self.global_position.y
	self.get_node("collbox").body_entered.connect(_hit)
	var post = create_tween()
	post.tween_property(self, "global_position:y", (posy + 250), 1)
	await get_tree().create_timer(0.7).timeout
	var modt = create_tween()
	modt.tween_property(self, "modulate", Color("ffffff00"), 0.3)
	await modt.finished
	self.queue_free()


func _process(_delta: float) -> void:
	self.rotate(1.8)

func _hit(body) -> void:
	if body.name == "Player" and canhit == true:
		canhit = false
		if body.health >= 2:
			body._playerhit(1)
		else:
			body._playerdeath("Loomer")
