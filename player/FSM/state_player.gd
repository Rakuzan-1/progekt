class_name StatePlayer
extends State
var player : Player

# Called when the node enters the scene tree for the first time.
func _ready():
	#что бы обращаться к свойстам player 
	player = owner as Player


