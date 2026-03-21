extends Label


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_coinupdate()

func _coinupdate() -> void:
	var coinamount = GameManager.coinamount
	self.text = str("%03d" % coinamount)
