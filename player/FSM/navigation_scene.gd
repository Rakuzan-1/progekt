extends Node
var scene_main = preload("res://scene/main.tscn")
var scene_shop = preload("res://scene/shop.tscn")

func swich_scene(dest_scene):
	var scene_to_load
	match dest_scene:
		"shop":
			scene_to_load = scene_shop
		"main":
			scene_to_load = null
	if scene_to_load != null:
		call_deferred("change_scene", scene_to_load)
func change_scene(scene):
	get_tree().change_scene_to_packed(scene)
