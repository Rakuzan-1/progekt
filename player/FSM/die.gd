extends StatePlayer
class_name die

#
#
func enter(_mess: Dictionary={}):
	print("1111111")
	player.animation.play("die")
	#обнуляем скорость
	player.velocity=Vector2.ZERO
	$"../../debag/VBox/state".set_text(name)
	$"../../Timer".start(2)

func inner_process(_delte: float):

	#print("1111111")
	player.animation.play("die")
	if $"../../Timer".is_stopped():
		player.queue_free()
	#if not player.is_on_floor():
		#state_machine.change_to("Fly")
		#
	#if  Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		#state_machine.change_to("Run")
		#
	#if Input.is_action_just_pressed("jump"):
		#state_machine.change_to("Fly",{do_jump = true})
	#if Input.is_action_just_pressed("Attack"):
		#state_machine.change_to("Attack")
	#if player.taken_hit==true:
		#state_machine.change_to("take_hit")
		#player.animation.play("take_hit")
		#player.taken_hit=false
#func _exit():
	#player.taken_hit=false


