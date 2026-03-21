extends Label


func _ready() -> void:
	self.text = str(GameManager.coinamount)
	self.get_parent().modulate = Color("ffffff00")

func _coinupdate() -> void:
	self.text = str(GameManager.coinamount)
	var t = create_tween().set_parallel(true)
	t.tween_property(self, "modulate", Color.WHITE, 0.12).from(Color("ffff00ff"))
	var t2 = create_tween()
	t2.tween_property(self.get_parent(), "modulate", Color.WHITE, 0.34).from(Color("ffffff00"))
	await get_tree().create_timer(3).timeout
	if self.get_parent().modulate == Color.WHITE:
		var t3 = create_tween()
		t3.tween_property(self.get_parent(), "modulate", Color("ffffff00"), 0.8).from(Color.WHITE)
