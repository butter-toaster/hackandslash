extends Node2D
var jultexture = preload("res://images/julien2.png")
var prottexture = preload("res://images/protagonist.png")
var locusttexture = preload("res://images/locustsprite.png")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if GameManager.juliensface == true:
		self.get_child(0).texture = jultexture
		self.get_child(0).scale.y = 0.05
		self.get_child(0).scale.x = 0.05
	else:
		self.get_child(0).texture = prottexture
		self.get_child(0).scale.y = 1
		self.get_child(0).scale.x = 1
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color("00000000"), 0.12)
	await tween.finished
