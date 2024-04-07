extends CharacterBody2D
class_name skilet
@onready var skile= $"."
const JUMP_VELOCITY = -400.0
@onready var animation=$AnimatedSprite2D
@onready var healthbar=$Healthbar
@onready var skil = $"."
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var max_hp=100
var health:int
var player=CharacterBody2D
var axis=[Vector2.LEFT,Vector2.RIGHT]
var state=idle
var speed_war=300
var speed_att=500
enum {
	attack,
	wandering,
	idle,
}
func _ready():
	
	health=100
	healthbar.init_health(health)
	randomize()
func _physics_process(delta):
	if skile != null and not skile.is_on_floor():
		velocity.y=gravity
		
	if state == idle:
		print("переход в состояние idle")
		if $TimerIdle.is_stopped():
			velocity=Vector2.ZERO
			animation.play("idle")
			$TimerIdle.start(randi_range(0,4))
	elif state==wandering:
		print("переход в состояние wander")
		if $Timerwandering.is_stopped():
			$Timerwandering.start(randi_range(1,4))
			velocity=axis.pick_random()*speed_war
			animation.play("run")
	elif state==attack:
		print("переход в состояние attack")
		$Timerwandering.stop()
		$TimerIdle.stop()
		var t=(player.global_position-self.global_position).normalized()
		velocity=(Vector2.LEFT if Vector2.RIGHT.dot(t) < Vector2.LEFT.dot(t) else Vector2.RIGHT)*speed_att
	#animation
	if velocity.x>0:
		animation.play("run")
		animation.set_flip_h(false)
	elif velocity.x<0:
		animation.play("run")
		animation.set_flip_h(true)
	move_and_slide()
	check_down(velocity)
func check_down(vel:Vector2):
	var speed=speed_war if state==wandering else speed_att
	vel=vel.normalized()
	if vel==Vector2.LEFT and !$RayCastL.is_colliding():
		velocity=Vector2.RIGHT*speed
	if vel==Vector2.RIGHT and !$RayCastR.is_colliding():
		velocity=Vector2.LEFT*speed

func _on_timerwandering_timeout():
	state= idle


func _on_detectivezone_body_entered(body):
	if body is Player and body is CharacterBody2D:
		player=body
		state=attack

func _on_exitzone_body_exited(body):
	if body==player:
		player=null
		state=idle

func _on_timer_idle_timeout():
	state= wandering

	
func take_hit(dmg: int):
	health-=dmg
	healthbar.health=health
	
	animation.play("take_hit")


func die():
	skil.queue_free()
#hp bar



