extends CharacterBody2D

var bigfrag = preload("res://images/cratefragment3.png")
var medfrag = preload("res://images/cratefragment2.png")
var smallfrag = preload("res://images/cratefragment.png")
var degreeincrements = [5, 6, 7, 8, 9, 10]
var texturepick = [1, 1, 1, 2, 2, 3]

func _ready() -> void:
	var texture = texturepick.pick_random()
	if texture == 1:
		self.get_child(0).texture = smallfrag
	elif texture == 2:
		self.get_child(0).texture = medfrag
	elif texture == 3:
		self.get_child(0).texture = bigfrag
		
	
	
	await get_tree().create_timer(1).timeout
	var tween = create_tween()
	tween.tween_property(self, "modulate", Color("ffffff00"), 1.3)
	await tween.finished
	self.queue_free()

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
		var degree = degreeincrements.pick_random()
		self.rotation_degrees += degree
	else:
		velocity.x -= 10
		if velocity.x <= 0:
			velocity.x = 0
		
	move_and_slide()

func _launch(force: float, angle_degrees: float):
	var direction = Vector2.UP.rotated(deg_to_rad(angle_degrees))
	velocity = direction * force
