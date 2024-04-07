extends Area2D
func hit():
	$"../../attack".set_text("You hit me in front")
	
	owner.take_hit(22)
