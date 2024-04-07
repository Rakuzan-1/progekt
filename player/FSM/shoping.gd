extends StatePlayer
class_name Shopping
func enter(_mes:Dictionary = {}):
	get_tree().paused = true
	$"../../debag/VBox/state".set_test(name)
func _physics_process(_delta):
	pass
func exit(_mess: Dictionary = {}):
	get_tree().paused = false
