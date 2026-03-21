extends Node2D
var sfx1 = preload("res://sfx/bushsfx1.mp3")
var sfx2 = preload("res://sfx/bushsfx2.mp3")
var bush1 = preload("res://images/bush1.png")
var bush2 = preload("res://images/bush2.png")
var bush3 = preload("res://images/bush3.png")
var bush4 = preload("res://images/bush4.png")
var bush5 = preload("res://images/bush5.png")
var bush6 = preload("res://images/bush6.png")
var bush7 = preload("res://images/bush7.png")
var bushshaved = preload("res://images/bush_shaved.png")
var pitchrandomizer = [0.8, 0.9, 1, 1.2, 1.3, 1.4, 1.5]
var sfxrandomizer = [1, 2]
var particlesleft = null
var canbehit = true


func _ready() -> void:
	var spriterand = randi_range(1, 7)
	match spriterand:
		1:
			$bushsprite.texture = bush1
		2:
			$bushsprite.texture  = bush2
		3:
			$bushsprite.texture  = bush3
		4:
			$bushsprite.texture  = bush4
		5:
			$bushsprite.texture  = bush5
		6:
			$bushsprite.texture  = bush6
		7:
			$bushsprite.texture  = bush7

func _on_bushhittrig_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if (area.name == "dashsword" or area.name == "sword") and canbehit == true:
		canbehit = false
		var sfx = sfxrandomizer.pick_random()
		var pitch = pitchrandomizer.pick_random()
		var number = sfxrandomizer.pick_random()
		
		particlesleft = number
		if sfx == 1:
			sfx = sfx1
		else:
			sfx = sfx2

		
		
		$bushsfx.stream = sfx
		$bushsfx.pitch_scale = pitch
		$bushsprite.texture = bushshaved
		$bushsfx.play()
		
		_particlespawn()
		var coinchance = randi_range(1, 100)
		if (GameManager.chance == true and coinchance <= 33) or (coinchance <= 30):
			var cpitch = randf_range(0.88, 1.12)
			$coinappearsfx.pitch_scale = cpitch
			$coinappearsfx.play()
			
			var coin = preload("res://coinpickup.tscn").instantiate()
			$"../..".call_deferred("add_child", coin)
			coin.global_position = self.global_position
				
func _particlespawn() -> void:
	particlesleft -= 1
	if particlesleft >= 0:
		var distance = %Player.global_position.x - self.global_position.x
		if distance <= 0:
			$tinyfragments.direction.x = 2000
			$bigfragments.direction.x = 1
			$sparks.direction.x = 2000
		else:
			$tinyfragments.direction.x = -2000
			$bigfragments.direction.x = -1
			$sparks.direction.x = -2000
			
		$sparks.emitting = true
		$tinyfragments.emitting = true
		$bigfragments.emitting = true
		_particlespawn()
	else:
		return
		
	
