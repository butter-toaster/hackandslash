extends OptionButton
@onready var nelem = get_tree().get_nodes_in_group("normalelements")
@onready var eelem = get_tree().get_nodes_in_group("expertlelements")

func _on_item_selected(index: int) -> void:
	if index == 0:
		get_tree().call_group("expertelements", "hide")
		get_tree().call_group("normalelements", "show")
		GameManager.normalmode = true
		GameManager.expertmode = false
		GameManager.modemultiplier = 1
		%dropdownswitchplayer.play()
		
	if index == 1:
		get_tree().call_group("expertelements", "show")
		get_tree().call_group("normalelements", "hide")
		GameManager.normalmode = false
		GameManager.expertmode = true
		GameManager.modemultiplier = 1.5
		%dropdownswitchplayer.play()
