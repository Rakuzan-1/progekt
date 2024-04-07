class_name Run
extends StatePlayer

func enter(_mess: Dictionary={}):
	$"../../debag/VBox/state".set_text(name)
func inner_physics_process(_delta):
	#var player.velocity = Vector2.ZERO # The player's movement vector.
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		player.velocity.x = lerp(player.velocity.x, direction*player.speed, 0.5)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0 ,player.speed/10.0)
	$"../../debag/VBox/velos".set_text(str(player.velocity))	
	player.move_and_slide()
	#переходы в другие состояния
	if not player.velocity and direction==0:
		state_machine.change_to("Idle")
	if not player.is_on_floor():
		state_machine.change_to("Fly")
	if Input.is_action_just_pressed("jump"):
		state_machine.change_to("Fly",{do_jump = true})
	if Input.is_action_just_pressed("Attack"):
		state_machine.change_to("Attack")	

	if player.velocity.x>0:
		player.animation.play("run")
		player.animation.set_flip_h(false)
	elif player.velocity.x<0:
		player.animation.play("run")
		player.animation.set_flip_h(true)




	#if direction_x :
		##print(direction_x)
		#player.velocity.x = direction_x * player.speed
	#else:
		#player.velocity.x = move_toward(player.velocity.x, 0, player.speed/10)
	#if direction:
		#player.velocity.y = direction_y * player.speed
	#else:
		#player.velocity.y = move_toward(player.velocity.y,0, player.speed/10)
	#ускорение если нажат шифт
	
		

