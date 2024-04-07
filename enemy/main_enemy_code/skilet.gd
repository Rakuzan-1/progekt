extends CharacterBody2D
class_name skilet
@onready var front_hti =$hitbox2/front
@onready var back_hit =$hitbox2/back
@onready var skile= $"."
const JUMP_VELOCITY = -400.0
@onready var animation=$AnimatedSprite2D
@onready var healthbar=$Healthbar
@onready var skil = $"."
@onready var def_attack =$zone/def_attack
var player=CharacterBody2D
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var max_hp=100
@onready var health:int
var axis=[Vector2.LEFT,Vector2.RIGHT]
var state=idle
var speed_war=100
var speed_att=200
@onready var area_att=false
enum {
	zamah,
	attack,
	wandering,
	idle,
}
func _ready():
	health=100
	healthbar.init_health(health)
	randomize()
func _physics_process(delta):
	if health<=0:
		die()
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if state == idle:
		
		if $TimerIdle.is_stopped():
			velocity=Vector2.ZERO
			animation.play("idle")
			$TimerIdle.start(randi_range(0,4))
	elif state==zamah:
		velocity=Vector2.ZERO
		animation.play("attack")
		$zamah.start(0.2)
		if $zamah.is_stopped():
			state=wandering
		
		
		
	elif state==wandering:
		
		if $Timerwandering.is_stopped():
			$Timerwandering.start(randi_range(1,4))
			velocity=axis.pick_random()*speed_war
			animation.play("run")
	elif state==attack:
		
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
		#flip zone
	if animation.is_flipped_h():
		def_attack.set_scale(Vector2(-1,1))
	else:
		def_attack.set_scale(Vector2(1,1))
	move_and_slide()
	check_down(velocity)
	
func check_down(vel:Vector2):
	var speed=speed_war if state==wandering else speed_att
	vel=vel.normalized()
	if vel==Vector2.LEFT and !$RayCastL.is_colliding():
		velocity=Vector2.RIGHT*speed
	if vel==Vector2.RIGHT and !$RayCastR.is_colliding():
		velocity=Vector2.LEFT*speed
		
func take_hit(dmg: int):
	#state=idle
	if health<=0:
		animation.play("die")
		front_hti.queue_free()
		back_hit.queue_free()
		#healthbar.queue_free()
	if health>0:
		health-=dmg
		healthbar.health=health
	
	$dmg.set_text(str(dmg))
	animation.play("hit")
	
func die():
	
	state=idle
	animation.play("die")
	
func _on_timerwandering_timeout():
	state= idle


func _on_detectivezone_body_entered(body):
	if body.name=="player":
		print("Player entered the zone")
		player = body
		state = attack

func _on_exitzone_body_exited(body):
	if body==player:
		player=null
		state=idle

func _on_timer_idle_timeout():
	state= wandering

	

func _on_animated_sprite_2d_animation_finished():
	if health<=0:
		skile.queue_free()

var alrady_hit=false
func _on_def_attack_area_entered(area):
	if area.name=="front_pl" or area.name=="back_pl":
		area_att=true
		state=zamah
		#animation.play("attack")
		if not alrady_hit:
			if area.has_method("hit"):
				area.hit()
			print(area.owner.name)
		alrady_hit=true
	elif area_att==false:
		state=idle	
	#print(area.name)
		#print("игрок зашел в зону атаки моба")
	
	#if area.has_method("hit"):
		
	#print(area.owner.name)
