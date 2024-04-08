class_name idle
extends StatePlayer


func enter(_mess: Dictionary={}):
	
	#обнуляем скорость
	player.velocity=Vector2.ZERO
	$"../../debag/VBox/state".set_text(name)
func inner_process(_delte: float):
	player.animation.play("idle")
	if not player.is_on_floor():
		state_machine.change_to("Fly")
		
	if  Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.change_to("Run")
		
	if Input.is_action_just_pressed("jump"):
		state_machine.change_to("Fly",{do_jump = true})
	if Input.is_action_just_pressed("Attack"):
		state_machine.change_to("Attack")
