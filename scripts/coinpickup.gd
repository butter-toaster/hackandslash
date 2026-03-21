extends Node2D

func _ready() -> void:
	var t = create_tween()
	t.tween_property($glimmer, "energy", 0, 0.1).from(0.2)

func _on_coincoll_body_entered(body: Node2D) -> void:
	if body.name == "Player":
		var pitch = randf_range(0.97, 1.03)
		var tweeny = global_position.y - 18
		$coincollectsfx.pitch_scale = pitch
		GameManager.coinamount += 1
		get_parent().get_node("coinamount/coincontrol/coinamtlabel")._coinupdate()
		$coincollectsfx.play()
		
		$coincoll.queue_free()
		var ctween = create_tween().set_parallel(true)
		ctween.tween_property(self, "position:y", tweeny, 0.3)
		ctween.tween_property(self, "modulate", Color("ffffff00"), 0.3)
		
		await get_tree().create_timer(0.8).timeout
		self.queue_free()
