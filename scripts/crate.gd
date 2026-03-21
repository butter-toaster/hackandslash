extends Node2D
var sfx1 = preload("res://sfx/crate1sfx.mp3")
var sfx2 = preload("res://sfx/crate2sfx.mp3")
var sfx3 = preload("res://sfx/crate3sfx.mp3")
var sfx4 = preload("res://sfx/crate4sfx.mp3")
var pitchrandomizer = [0.8, 0.9, 1, 1.2, 1.3, 1.4, 1.5]
var sfxrandomizer = [1, 2, 3 ,4]
var particlesleft = null
var canbehit = true


func _on_cratehittrig_area_shape_entered(_area_rid: RID, area: Area2D, _area_shape_index: int, _local_shape_index: int) -> void:
	if (area.name == "dashsword" or area.name == "sword") and canbehit == true:
		canbehit = false
		var sfx = sfxrandomizer.pick_random()
		var pitch = pitchrandomizer.pick_random()
		var number = sfxrandomizer.pick_random()
		
		particlesleft = number
		if sfx == 1:
			sfx = sfx1
		elif sfx == 2:
			sfx = sfx2
		elif sfx == 3:
			sfx = sfx3
		else:
			sfx = sfx4
		
		$cratesfx.stream = sfx
		$cratesfx.pitch_scale = pitch
		$cratesfx.play()
		$cratesprite.hide()
		
		_particlespawn()
		var coinchance = randi_range(1, 100)
		if (GameManager.chance == true and coinchance <= 32) or (coinchance <= 29):
			var cpitch = randf_range(0.88, 1.12)
			$coinappearsfx.pitch_scale = cpitch
			$coinappearsfx.play()
			
			var coin = preload("res://coinpickup.tscn").instantiate()
			$"../..".call_deferred("add_child", coin)
			coin.global_position = self.global_position
		
		
		await get_tree().create_timer(0.5).timeout
		self.queue_free()
		
func _particlespawn() -> void:
	particlesleft -= 1
	if particlesleft >= 0:
		var distance = %Player.global_position.x - self.global_position.x
		var force = randi_range(220, 400)
		var angle = randi_range(25, 45)
		var negangle = randi_range(-45, -25)
		var fragment = preload("res://cratefragmentbody.tscn").instantiate()
		
		$"../..".call_deferred("add_child", fragment)
		fragment.global_position = self.global_position
		if distance <= 0:
			fragment.get_child(0)._launch(force, angle)
			$tinyfragments.direction.x = 2000
			$bigfragments.direction.x = 2000
			$sparks.direction.x = 2000
		else:
			fragment.get_child(0)._launch(force, negangle)
			$tinyfragments.direction.x = -2000
			$bigfragments.direction.x = -2000
			$sparks.direction.x = -2000
			
		$sparks.emitting = true
		$tinyfragments.emitting = true
		$bigfragments.emitting = true
		_particlespawn()
	else:
		return
		
	
