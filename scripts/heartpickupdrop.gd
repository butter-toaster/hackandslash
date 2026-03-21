extends Node2D
var effect = preload("res://heartparticles.tscn").instantiate()
@onready var heartparticles = effect.find_child("heartparticles")

func _ready() -> void:
	self.get_child(1).body_entered.connect(_heartpickup)

func _heartpickup(body) -> void:
	if body.name == "Player":
		var heartself = body
		$"..".add_child(effect)
		effect.global_position = heartself.global_position
		heartparticles.emitting = true
		%Player._playerheal(1)
		%heartsfx.play()
		%scorecounternode.score += int(100 * GameManager.debugscoremultiplier * GameManager.modemultiplier)
		%scorecounternode._scoreupdate()
		queue_free()
