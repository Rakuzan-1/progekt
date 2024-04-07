extends Control
var scare_crow: scarecrow

func _draw():
	# Рисование фона HP bar
	draw_rect(Rect2(0, 0, 80, 180), Color(0.2, 0.2, 0.2))
	
	# Рисование текущего HP
	var hp_percent = scare_crow.hp / scare_crow.max_hp
	draw_rect(Rect2(0, 0, width * hp_percent, height), Color(0.8, 0.2, 0.2))

func set_hp(hp):
	scare_crow.hp = hp
	update()
