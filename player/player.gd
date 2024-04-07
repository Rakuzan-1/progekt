class_name Player
extends CharacterBody2D

@export var speed = 390

var jump_velocity = -450
@onready var animation = $AnimatedSprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var zone = $zone
@onready var def_attack= $zone/def_attack

func take_hit(dmg: int):
	#health-=dmg
	#healthbar.health=health
	animation.play("take_hit")
