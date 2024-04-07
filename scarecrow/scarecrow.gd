extends CharacterBody2D
class_name scarecrow

const JUMP_VELOCITY = -400.0
@onready var animation=$AnimatedSprite2D
@onready var healthbar=$Healthbar
@onready var scar = $"."
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var max_hp=100
var health:int
func _ready():
	health=100
	healthbar.init_health(health)
func _physics_process(delta):
	# Add the gravity.
	if health<=0:
		die()
	if not is_on_floor():
		velocity.y += gravity * delta
	move_and_slide()
func take_hit(dmg: int):
	health-=dmg
	healthbar.health=health
	$dmg.set_text(str(dmg))
	animation.play("take_hit")


func die():
	scar.queue_free()
#hp bar

