extends Node2D
var effect = preload("res://deathparticles.tscn").instantiate()
@onready var dparticles = effect.find_child("deathparticles")

func _ready() -> void:
	self.get_child(1).body_entered.connect(_perkpickup)

func _perkpickup(body) -> void:
	if body.name == "Player":
		var coinself = body
		$"..".add_child(effect)
		effect.global_position = coinself.global_position
		dparticles.emitting = true
		if %perkslothandler.slot5full == true:
			%Player._playerheal(1)
			%scorecounternode.score += int(2500 * GameManager.debugscoremultiplier * GameManager.modemultiplier)
			%scorecounternode._scoreupdate()
			queue_free()
		else:
			%perkappearsfx.play()
			%scorecounternode.score += int(150 * GameManager.debugscoremultiplier * GameManager.modemultiplier)
			%scorecounternode._scoreupdate()
			%LEFTOPTIONS._perkcoinactivated()
			queue_free()
