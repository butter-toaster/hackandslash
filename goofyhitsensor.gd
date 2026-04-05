extends Area2D
@onready var deathsfx = $"../../goofyplayer/deathsfx"
@onready var youlose = $"../../youlose"
@onready var bgmusic = $"../../bgmusic"
@onready var jumpscare = $"../../jumpscare/jumpscare"

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.body_entered.connect(_hit)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _hit(body) -> void:
	if body.name == "goofyplayer":
		var t = create_tween()
		t.tween_property(jumpscare, "modulate", Color("ffffff00"), 1.1).from(Color.WHITE).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_SINE)
		body.deathlock = true
		deathsfx.play()
		youlose.show()
		bgmusic.stream_paused = true
