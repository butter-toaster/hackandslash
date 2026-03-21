extends Button
var swiftness = preload("res://images/speedperk.png")
var justpressed = false

func _ready() -> void:
	self.mouse_entered.connect(_mouseenter)
	self.mouse_exited.connect(_mouseexit)
func _mouseenter() -> void:
	var tweenpos = create_tween()
	tweenpos.tween_property(self.get_parent(), "position:y", -8, 0.1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).from(0)
	%perkhoversfx.play()
func _mouseexit() -> void:
	var tweenpos = create_tween()
	tweenpos.tween_property(self.get_parent(), "position:y", 0, 0.1).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).from(-8)


func _on_pressed() -> void:
	justpressed = true
	%perkcinemabars._perkcinebarsretreat()
	%perkselectsfx.play()
	%Player.swiftnessfactor += 18.2
	get_tree().call_group("leftperkoptions", "hide")
	get_tree().call_group("rightperkoptions", "hide")
	get_tree().call_group("middleperkoptions", "hide")
	var blurtween = create_tween()
	blurtween.tween_property(%perkblur.material, "shader_parameter/lod", 0, 0.2)

	if justpressed == true and %perkslothandler.slot1full == false:
		%perkslotrect.texture = swiftness
		%perkslothandler.slot1full = true
		justpressed = false
	if justpressed == true and %perkslothandler.slot1full == true and %perkslothandler.slot2full == false:
		%perkslotrect2.texture = swiftness
		%perkslothandler.slot2full = true
		justpressed = false
	if justpressed == true and %perkslothandler.slot2full == true and %perkslothandler.slot3full == false:
		%perkslotrect3.texture = swiftness
		%perkslothandler.slot3full = true
		justpressed = false
	if justpressed == true and %perkslothandler.slot3full == true and %perkslothandler.slot4full == false:
		%perkslotrect4.texture = swiftness
		%perkslothandler.slot4full = true
		justpressed = false
	if justpressed == true and %perkslothandler.slot4full == true and %perkslothandler.slot5full == false:
		%perkslotrect5.texture = swiftness
		%perkslothandler.slot5full = true
		justpressed = false
