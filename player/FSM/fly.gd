class_name Fly
extends StatePlayer
var jmp=false
func enter(mess: Dictionary={}):
	#fix animation fly
	#player.velocity=Vector2.ZERO
	if mess.has("do_jump"):
		jmp=true
		player.velocity.y = player.jump_velocity
	$"../../debag/VBox/state".set_text(name)
func inner_physics_process(delta):
	
	player.velocity.y+= (player.gravity-20) * delta
	if player.velocity.y > 0:  # If still ascending
		player.velocity.y = lerp(player.velocity.y, 0.0, delta * 2.5)
	#if player.velocity.y<0:
		#player.velocity.y=move_toward(player.velocity.y,float(player.jump_velocity),delta/10)
	#animation
	if player.velocity.y<0:
		player.animation.play("jump")
	elif player.velocity.y>10:
		player.animation.play("fall")
	else:
		player.animation.play("fall")
	
	
	var direction = Input.get_axis("move_left", "move_right")
	if direction:
		player.velocity.x = lerp(player.velocity.x, direction*player.speed, 0.5)
	else:
		player.velocity.x = move_toward(player.velocity.x, 0 ,player.speed/10.0)
	$"../../debag/VBox/velos".set_text(str(player.velocity))
	
	if direction<0:
		player.animation.set_flip_h(true)
	elif direction>0:
		player.animation.set_flip_h(false)
	player.move_and_slide()
	if player.is_on_floor():
		if player.velocity.x==0:
			state_machine.change_to("Idle",{do_jump=true})
		else:
			state_machine.change_to("Run")
func exit():
	jmp=false
