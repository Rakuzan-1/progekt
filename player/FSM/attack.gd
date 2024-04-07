extends StatePlayer
class_name Attack
var alrady_hit:bool
func enter(_msg: Dictionary={}):
	alrady_hit=false
	$"../../debag/VBox/state".set_text(str(name))
	player.def_attack.set_monitoring(true)
	if player.animation.is_flipped_h():
		player.def_attack.set_scale(Vector2(-1,1))
	else:
		player.def_attack.set_scale(Vector2(1,1))
func inner_physics_process(_delta):

	if not player.is_on_floor():
		state_machine.change_to("Fly")
	player.animation.play("attack")

func _on_area_2d_area_entered(area):
	if not alrady_hit:
		if area.has_method("hit"):
			area.hit()
		print(area.owner.name)
	alrady_hit=false



func _on_animated_sprite_2d_animation_finished():
	if Input.is_action_just_pressed("jump"):
		state_machine.change_to("Fly",{do_jump=true})
	elif Input.is_action_pressed("move_left") or Input.is_action_pressed("move_right"):
		state_machine.change_to("Run")	
	#
	elif Input.is_action_pressed("Attack"):
		state_machine.change_to("Attack")	
	else:
		state_machine.change_to("Idle")
func exit():
	player.def_attack.set_monitoring(false)
