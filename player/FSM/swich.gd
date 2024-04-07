extends Area2D
class_name Swich
@export var dist_scene : String
@export var dist_tag : String

var player : Player
var player_area_tp:bool
func _on_body_entered(body):
	if body is Player :
		print("вошел в зону тп")

		player_area_tp=true
		#NavigationScene.swich_scene(dist_scene)


func _on_body_exited(body):
	if body is Player :
		player_area_tp=false
		print("вышел из зоны тп")
func _process(_delta):
	if player_area_tp==true and dist_scene== "main" and Input.is_action_just_pressed("interaction"):
		DialogueManager.show_dialogue_balloon(load("res://dialoge/froge_shop.dialogue"), "start")
		return
	if Input.is_action_just_pressed("interaction") and player_area_tp==true:
		NavigationScene.swich_scene(dist_scene)

