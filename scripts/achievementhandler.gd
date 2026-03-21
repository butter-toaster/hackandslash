extends Node

func _ready() -> void:
	if GameManager.newbeg != false:
		_achactivate(%newbeginning)
	if GameManager.expbeat != false:
		_achactivate(%expertbeat)
	if GameManager.julbeat != false:
		_achactivate(%julienbeat)
	if GameManager.scoreaddict != false:
		_achactivate(%scoreaddict)
	if GameManager.broom != false:
		_achactivate(%broom)
	if GameManager.sweet != false:
		_achactivate(%sweet)
	if GameManager.pity != false:
		_achactivate(%pity)
	if GameManager.uneventful != false:
		_achactivate(%uneventful)
	if GameManager.morales != false:
		_achactivate(%morales)
	if GameManager.selfdest != false:
		_achactivate(%selfdest)
	if GameManager.graveyard != false:
		_achactivate(%graveyard)

func _achactivate(ach) -> void:
	ach.modulate = Color.WHITE
	ach.get_child(1).show()

func _achshow(icon, text, scale) -> void:
	%achicon.texture = icon
	%achicon.scale.x = scale
	%achicon.scale.y = scale
	%achname.text = str(text)
	await get_tree().create_timer(1.5).timeout
	%achunlockedsfx.play()
	var tween = create_tween()
	tween.tween_property(%achtab, "position:y", 0, 0.15).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).from(-150)
	await get_tree().create_timer(4.5).timeout
	var tween2 = create_tween()
	tween2.tween_property(%achtab, "position:y", -150, 0.15).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).from(0)
