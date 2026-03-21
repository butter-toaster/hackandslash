extends Control
var settingsopen = false
var expbeaticon = preload("res://images/expertprotagonist.png")
var normalbeaticon = preload("res://images/protagonist.png")
var julienbeaticon = preload("res://images/julien2.png")
var loserachicon = preload("res://images/loser.png")
var score180icon = preload("res://images/scoreaddict.png")
var score0icon = preload("res://images/moralesscore.png")


func _ready() -> void:
	var bus_index = AudioServer.get_bus_index("Music")
	AudioServer.set_bus_volume_db(bus_index, -80)
	await get_tree().create_timer(1).timeout
	if self.has_node("notsupposedtobehere"):
		pass
	else:
		%menutheme.play()
	AudioServer.set_bus_volume_db(bus_index, 0)
	%TRANSHANDLER._barsout()
	if GameManager.justwon == true:
		if GameManager.normalmode == true and GameManager.newbeg == false:
			GameManager.newbeg = true
			%ACHIEVEMENTHANDLER._achactivate(%newbeginning)
			%ACHIEVEMENTHANDLER._achshow(normalbeaticon, "A NEW BEGINNING", 1)
		if GameManager.expertmode == true and GameManager.expbeat == false:
			GameManager.expbeat = true
			%ACHIEVEMENTHANDLER._achactivate(%expertbeat)
			%ACHIEVEMENTHANDLER._achshow(expbeaticon, "A WORTHY OPPONENT", 1)
		if GameManager.juliensface == true and GameManager.julbeat == false:
			GameManager.julbeat = true
			%ACHIEVEMENTHANDLER._achactivate(%julienbeat)
			%ACHIEVEMENTHANDLER._achshow(julienbeaticon, "SKADOOSH", 0.2)
		if GameManager.scoreaddict == false and GameManager.had180Kscore == true:
			GameManager.scoreaddict = true
			%ACHIEVEMENTHANDLER._achactivate(%scoreaddict)
			%ACHIEVEMENTHANDLER._achshow(score180icon, "SCORE ADDICT", 1)
		if GameManager.morales == false and GameManager.hadnolevelscore == true:
			GameManager.morales = true
			%ACHIEVEMENTHANDLER._achactivate(%morales)
			%ACHIEVEMENTHANDLER._achshow(score0icon, "MORALES TEST SCORE", 1)		
		if GameManager.pity == false and GameManager.hadnoloserkills == true:
			GameManager.pity = true
			%ACHIEVEMENTHANDLER._achactivate(%pity)
			%ACHIEVEMENTHANDLER._achshow(loserachicon, "PITY, I PRITHEE", 1)
		GameManager.justwon = false
	
	if GameManager.expertmode == false:
		get_tree().call_group("expertelements", "hide")
		get_tree().call_group("normalelements", "show")
		%difficultyselectbutton.selected = 0
	else:
		get_tree().call_group("expertelements", "show")
		get_tree().call_group("normalelements", "hide")
		%difficultyselectbutton.selected = 1

func _process(_delta: float) -> void:
	if settingsopen == true:
		if Input.is_key_pressed(KEY_Q):
			%q.show()
		else:
			%q.hide()
		
		if Input.is_key_pressed(KEY_P):
			%p.show()
		else:
			%p.hide()
		
		if Input.is_key_pressed(KEY_SPACE):
			%space.show()
		else:
			%space.hide()
		
		if Input.is_key_pressed(KEY_D):
			%d.show()
		else:
			%d.hide()
			
		if Input.is_key_pressed(KEY_A):
			%a.show()
		else:
			%a.hide()
		
		if Input.is_key_pressed(KEY_K):
			%k.show()
		else:
			%k.hide()
			
		if Input.is_key_pressed(KEY_SHIFT):
			%shift.show()
		else:
			%shift.hide()
			
		if Input.is_mouse_button_pressed(MOUSE_BUTTON_LEFT):
			%mouse.show()
		else:
			%mouse.hide()
