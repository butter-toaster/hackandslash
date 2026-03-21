extends Control
var perkoptions = [0, 0, 0, 0, 0, 1, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5]

func _ready() -> void:
	if GameManager.chance == true:
		perkoptions = [0, 0, 0, 1, 1, 1, 2, 2, 2, 3, 3, 3, 4, 4, 5, 5]

func _perkcoinactivated() -> void:
	$"../../perkappearsfx".play()
	%perkcinemabars._perkcinebarsstart()
	var blurtween = create_tween()
	blurtween.tween_property(%perkblur.material, "shader_parameter/lod", 2.5, 0.2).set_trans(Tween.TRANS_SINE).set_ease(Tween.EASE_OUT)
		
	var perkresult = perkoptions.pick_random()
	if perkresult == 0:
		$scorebonus.show()
	if perkresult == 1:
		$recovery.show()
	if perkresult == 2:
		$swiftness.show()
	if perkresult == 3:
		$quickdraw.show()
	if perkresult == 4:
		$hermesboots.show()
	if perkresult == 5:
		$dashplus.show()
			
	var perkresult2 = perkoptions.pick_random()
	if perkresult2 == 0:
		$"../MIDDLEOPTIONS/scorebonus".show()
	if perkresult2 == 1:
		$"../MIDDLEOPTIONS/recovery".show()
	if perkresult2 == 2:
		$"../MIDDLEOPTIONS/swiftness".show()
	if perkresult2 == 3:
		$"../MIDDLEOPTIONS/quickdraw".show()
	if perkresult2 == 4:
		$"../MIDDLEOPTIONS/hermesboots".show()
	if perkresult2 == 5:
		$"../MIDDLEOPTIONS/dashplus".show()
			
	var perkresult3 = perkoptions.pick_random()
	if perkresult3 == 0:
		$"../RIGHTOPTIONS/scorebonus".show()
	if perkresult3 == 1:
		$"../RIGHTOPTIONS/recovery".show()
	if perkresult3 == 2:
		$"../RIGHTOPTIONS/swiftness".show()
	if perkresult3 == 3:
		$"../RIGHTOPTIONS/quickdraw".show()
	if perkresult3 == 4:
		$"../RIGHTOPTIONS/hermesboots".show()
	if perkresult3 == 5:
		$"../RIGHTOPTIONS/dashplus".show()
	else:
		pass
