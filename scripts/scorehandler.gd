extends Node2D
var changeoccured = false
var score = 0

func _scoreupdate() -> void:	
	%LEVELHANDLER.nolevelscore = false
	var formatted_score = "%06d" % score
	$scorecounter/Label.text = formatted_score
		
	%Label.modulate = Color("b1fdd7ff")
	var colortween = create_tween()
	colortween.tween_property(%Label, "modulate", Color.WHITE, 0.35)
