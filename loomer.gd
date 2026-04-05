extends Node2D
@onready var root = self.get_parent().get_parent()
@onready var player = root.get_node("Player")

func _ready() -> void:
	_attackseq()

func _attackseq() -> void:
	var distance = self.global_position.x - player.global_position.x
	if distance <= 300 and distance >= -300:
		var t = create_tween()
		t.tween_property($chargeup, "modulate", Color("ed0046"), 2).from(Color("ed004600")).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_QUAD)
		await get_tree().create_timer(2).timeout
		var shot = preload("res://loomershot.tscn").instantiate()
		root.add_child(shot)
		shot.global_position = self.global_position
		_attackseq()
		
	else:
		await get_tree().create_timer(3).timeout
		_attackseq()
	
