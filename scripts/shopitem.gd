extends Control
@onready var physicalitem = $physicalitem
@onready var hoverglow = $hoveredglow.get_child(0)
@onready var pricetag = $purchasebar
@onready var price = int(self.get_child(6).name)

var nodeself = null
var gmvarself = null
var nodetype = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$physicalitem/mousedetector.mouse_entered.connect(_hoveron)
	$physicalitem/mousedetector.mouse_exited.connect(_hoveroff)
	$physicalitem/mousedetector.gui_input.connect(_clicked)
	set_process(false)
	
	match self.name:
		"guide":
			nodeself = %guide
			gmvarself = "i1"
			nodetype = "i"
		"rapier":
			nodeself = %rapier
			gmvarself = "i2"
			nodetype = "i"
		"sandpaper":
			nodeself = %sandpaper
			gmvarself = "i3"
			nodetype = "i"
		"flask":
			nodeself = %flask
			gmvarself = "i4"
			nodetype = "i"
		"drug":
			nodeself = %drug
			gmvarself = "i5"
			nodetype = "i"
		"marvel":
			nodeself = %marvel
			gmvarself = "i6"
			nodetype = "i"
		
		"onyx":
			nodeself = %onyx
			gmvarself = "c1"
			nodetype = "c"
		"chance":
			nodeself = %chance
			gmvarself = "c2"
			nodetype = "c"
		"lifesteal":
			nodeself = %lifesteal
			gmvarself = "c3"
			nodetype = "c"
		"zeus":
			nodeself = %zeus
			gmvarself = "c4"
			nodetype = "c"
		"omnipotence":
			nodeself = %omnipotence
			gmvarself = "c5"
			nodetype = "c"
			
	_setup()
	
	
func _process(_delta: float) -> void:
	if price > 0:
		price -= 1
		$purchasebar/price.text = str(price)
	




func _hoveron() -> void:
	var postween = create_tween()
	postween.tween_property(physicalitem, "position:y", -7, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).from(0)
	var postween2 = create_tween()
	postween2.tween_property(hoverglow, "position:y", -7, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).from(0)
	var modtween = create_tween()
	modtween.tween_property(hoverglow, "modulate", Color("ffffff77"), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).from(Color("ffffff00"))
	var pricetween = create_tween()
	pricetween.tween_property(pricetag, "scale", Vector2(1.07, 1.07), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).from(Vector2(1, 1))
	%itemhoversfx.play()
	$itemcheck.show()

func _hoveroff() -> void:
	var postween = create_tween()
	postween.tween_property(physicalitem, "position:y", 0, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).from(-7)
	var postween2 = create_tween()
	postween2.tween_property(hoverglow, "position:y", 0, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).from(-7)
	var modtween = create_tween()
	modtween.tween_property(hoverglow, "modulate", Color("ffffff00"), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).from(Color("ffffff77"))
	var pricetween = create_tween()
	pricetween.tween_property(pricetag, "scale", Vector2(1, 1), 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE).from(Vector2(1.07, 1.07))
	$itemcheck.hide()
	
	
	
	
func _clicked(event) -> void:
	if event.is_action_pressed("attack"):
		var tween = create_tween()
		tween.tween_property(self.get_child(3).get_child(0), "scale", Vector2(1, 1), 0.1).from(Vector2(1.04, 1.04))
		match gmvarself:
			"c1":
				_clickaftercheck(GameManager.onyxbought)
			"c2":
				_clickaftercheck(GameManager.chancebought)
			"c3":
				_clickaftercheck(GameManager.lifestealbought)
			"c4":
				_clickaftercheck(GameManager.zeusbought)
			"c5":
				_clickaftercheck(GameManager.omnipotencebought)
			"i1":
				_clickaftercheck(GameManager.guidebought)
			"i2":
				_clickaftercheck(GameManager.rapierbought)
			"i3":
				_clickaftercheck(GameManager.sandpaperbought)
			"i4":
				_clickaftercheck(GameManager.flaskbought)
			"i5":
				_clickaftercheck(GameManager.drugbought)
			"i6":
				_clickaftercheck(GameManager.marvelbought)


func _clickaftercheck(bought) -> void:
	if bought == true:
		_clickfinalcheck()
	if bought == false:
		if GameManager.coinamount >= price:
			match gmvarself:
				"c1":
					GameManager.onyxbought = true
				"c2":
					GameManager.chancebought = true
				"c3":
					GameManager.lifestealbought = true
				"c4":
					GameManager.zeusbought = true
				"c5":
					GameManager.omnipotencebought = true
				"i1":
					GameManager.guidebought = true
				"i2":
					GameManager.rapierbought = true
				"i3":
					GameManager.sandpaperbought = true
				"i4":
					GameManager.flaskbought = true
				"i5":
					GameManager.drugbought = true
				"i6":
					GameManager.marvelbought = true
			_equip("manual")
			GameManager.coinamount -= price
			$itemcheck/owned.show()
			%achunlockedsfx.play()
			$buyparticles.emitting = true
			%balance._coinupdate()
			set_process(true)
			var pricetween = create_tween()
			pricetween.tween_property(pricetag, "modulate", Color("ffffff00"), 0.8)
			await pricetween.finished
			pricetag.hide()
			set_process(false)
			return
		else:
			%cantbuysfx.play()

func _clickfinalcheck() -> void:
	match gmvarself:
			"c1":
				if GameManager.onyx == true: 
					_unequip()
				else:
					_equip("manual")
			"c2":
				if GameManager.chance == true:
					_unequip()
				else:
					_equip("manual")
			"c3":
				if GameManager.lifesteal == true:
					_unequip()
				else:
					_equip("manual")
			"c4":
				if GameManager.zeus == true:
					_unequip()
				else:
					_equip("manual")
			"c5":
				if GameManager.omnipotence == true:
					_unequip()
				else:
					_equip("manual")
			"i1":
				if GameManager.guide == true:
					_unequip()
				else:
					_equip("manual")
			"i2":
				if GameManager.rapier == true:
					_unequip()
				else:
					_equip("manual")
			"i3":
				if GameManager.sandpaper == true:
					_unequip()
				else:
					_equip("manual")
			"i4":
				if GameManager.flask == true:
					_unequip()
				else:
					_equip("manual")
			"i5":
				if GameManager.drug == true:
					_unequip()
				else:
					_equip("manual")
			"i6":
				if GameManager.marvel == true:
					_unequip()
				else:
					_equip("manual")

func _equip(type) -> void:
	if nodetype == "c":
		GameManager.onyx = false
		GameManager.chance = false
		GameManager.lifesteal = false
		GameManager.zeus = false
		GameManager.omnipotence = false
		%charmnameequipped.text = str(nodeself.get_child(0).get_child(0).text)
		get_tree().call_group("equippedglows_charms", "hide")
		if type == "manual":
			%charmequippedsfx.play()
	else:
		GameManager.guide = false
		GameManager.rapier = false
		GameManager.sandpaper = false
		GameManager.flask = false
		GameManager.drug = false
		GameManager.marvel = false
		%itemnameequipped.text = str(nodeself.get_child(0).get_child(0).text)
		get_tree().call_group("equippedglows_items", "hide")
		if type == "manual":
			%itemequippedsfx.play()
	match gmvarself:
		"c1":
			GameManager.onyx = true
		"c2":
			GameManager.chance = true
		"c3":
			GameManager.lifesteal = true
		"c4":
			GameManager.zeus = true
		"c5":
			GameManager.omnipotence = true
		"i1":
			GameManager.guide = true
		"i2":
			GameManager.rapier = true
		"i3":
			GameManager.sandpaper = true
		"i4":
			GameManager.flask = true
		"i5":
			GameManager.drug = true
		"i6":
			GameManager.marvel = true
		
	nodeself.get_child(0).get_child(2).show() #equipped
	nodeself.get_child(2).show()
	
	


func _unequip() -> void:
	if nodetype == "c":
		GameManager.onyx = false
		GameManager.chance = false
		GameManager.lifesteal = false
		GameManager.zeus = false
		GameManager.omnipotence = false
		%charmnameequipped.text = "N/A"
		get_tree().call_group("equippedglows_charms", "hide")
	else:
		GameManager.guide = false
		GameManager.rapier = false
		GameManager.sandpaper = false
		GameManager.flask = false
		GameManager.drug = false
		GameManager.marvel = false
		%itemnameequipped.text = "N/A"
		get_tree().call_group("equippedglows_items", "hide")
		
	nodeself.get_child(2).hide()
	nodeself.get_child(0).get_child(2).hide() #equipped
	%unequippedsfx.play()
	
	

func _setup() -> void:
	match gmvarself:
			"c1":
				if GameManager.onyxbought == true:
					pricetag.hide()
					$itemcheck/owned.show()
					if GameManager.onyx == true: 
						_equip("setup")
			"c2":
				if GameManager.chancebought == true:
					pricetag.hide()
					$itemcheck/owned.show()
					if GameManager.chance == true: 
						_equip("setup")
			"c3":
				if GameManager.lifestealbought == true:
					pricetag.hide()
					$itemcheck/owned.show()
					if GameManager.lifesteal == true: 
						_equip("setup")
			"c4":
				if GameManager.zeusbought == true:
					pricetag.hide()
					$itemcheck/owned.show()
					if GameManager.zeus == true: 
						_equip("setup")
			"c5":
				if GameManager.omnipotencebought == true:
					pricetag.hide()
					$itemcheck/owned.show()
					if GameManager.omnipotences == true: 
						_equip("setup")
			"i1":
				if GameManager.guidebought == true:
					pricetag.hide()
					$itemcheck/owned.show()
					if GameManager.guide == true: 
						_equip("setup")
			"i2":
				if GameManager.rapierbought == true:
					pricetag.hide()
					$itemcheck/owned.show()
					if GameManager.rapier == true: 
						_equip("setup")
			"i3":
				if GameManager.sandpaperbought == true:
					pricetag.hide()
					$itemcheck/owned.show()
					if GameManager.sandpaper == true: 
						_equip("setup")
			"i4":
				if GameManager.flaskbought == true:
					pricetag.hide()
					$itemcheck/owned.show()
					if GameManager.flask == true: 
						_equip("setup")
			"i5":
				if GameManager.drugbought == true:
					pricetag.hide()
					$itemcheck/owned.show()
					if GameManager.drug == true: 
						_equip("setup")
			"i6":
				if GameManager.marvelbought == true:
					pricetag.hide()
					$itemcheck/owned.show()
					if GameManager.marvel == true: 
						_equip("setup")
		
