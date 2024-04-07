class_name Player
extends CharacterBody2D
@onready var health
@export var speed = 390
@onready var healthbar = $Healthbar
var jump_velocity = -450
@onready var animation = $AnimatedSprite2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var taken_hit=false
@onready var zone = $zone
@onready var def_attack= $zone/def_attack
@onready var front_hti=$hitbox_player/front_pl
@onready var back_hit=$hitbox_player/back_pl
@onready var time = $Timer
func _ready():
	health=100
	healthbar.init_health(health)

func take_hit(dmg: int):
	taken_hit=true
	if health<=0:
		front_hti.queue_free()
		back_hit.queue_free()
	elif health>0:
		health-=dmg
		healthbar.health=health

func die():
	pass
func _on_animated_sprite_2d_animation_finished():
	taken_hit=false
