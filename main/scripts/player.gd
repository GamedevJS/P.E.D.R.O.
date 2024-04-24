class_name Player
extends BaseCreature


var BASE_SPEED : float = 5000.0
var LASER_COOLDOWN : bool = false

var SEN_45 = pow(2, 1/2)/2

@onready var animation := $Player as AnimationPlayer
@onready var sprites := $Sprites as Sprite2D
@onready var hit_cooldown_timer := $HitCooldown as Timer
@onready var attack_cooldown_timer := $AttackCooldown as Timer
@onready var laser_cooldown_timer := $LaserCooldown as Timer
@onready var attack := $Attack as PlayerAttackComponent
@onready var camera := $Camera as Camera2D

@onready var laser_beam = load("res://main/scenes/projectiles/Laser.tscn")

func _ready():
	SPEED = BASE_SPEED
	
func _physics_process(delta):
	movment_handler(delta)
	attack_handler()
	move_and_slide()
	

func _process(delta):
	animation_handler()	
		


func movment_handler(delta):
		DIR = Vector2(
			Input.get_action_strength("right") - Input.get_action_strength("left"),
			Input.get_action_strength("down") - Input.get_action_strength("up")
		)
		velocity = DIR * SPEED * delta
		
		if INVINCILITY:
			velocity += KNOCKBACK

func animation_handler():
	
	if !ATTACKING:
		if DIR.x != 0:
			sprites.scale.x = -DIR.x
		#if velocity != Vector2.ZERO:
		animation.play("walking")
			

func attack_handler():
	
	if Input.is_action_just_pressed("attack1") and !ATTACK_COOLDOWN:
		attack1()
	if Input.is_action_just_pressed("attack2") and !ATTACK_COOLDOWN:
		attack2()
		

func attack1():
	ATTACKING = true
	SPEED = SPEED * 0.1
	ATTACK_COOLDOWN = true
	var _pos = camera.get_global_mouse_position().x - position.x
	if _pos >= 0:
		animation.play("attack_right")
		sprites.scale.x = -1
	else:
		animation.play("attack_left")
		sprites.scale.x = 1
	attack_cooldown_timer.set_wait_time(animation.current_animation_length)
	attack_cooldown_timer.start()
	attack.enable_attack()


func attack2():
	ATTACKING = true
	ATTACK_COOLDOWN = true
	SPEED = 0
	var laser : Laser = laser_beam.instantiate()
	
	var target_pos = (camera.get_global_mouse_position() - position).normalized()
	if target_pos.x >= 0:
		animation.play("laser_attack")
		sprites.scale.x = -1
		laser.position = position + Vector2(40,0)
	else:
		animation.play("laser_attack")
		sprites.scale.x = 1
		laser.position = position + Vector2(-40,0)
	
	laser.ATTACK_DIR = target_pos
	get_parent().add_child(laser)
	
	attack_cooldown_timer.set_wait_time(animation.current_animation_length)
	attack_cooldown_timer.start()


func handle_attack_direction():
	var attack_dir = get_local_mouse_position() - position
	if attack_dir.y < SEN_45 * attack_dir.x and attack_dir.y < -SEN_45 * attack_dir.x:
		return 1
	elif attack_dir.y >= SEN_45 * attack_dir.x and attack_dir.y < -SEN_45 * attack_dir.x:
		return 2
	elif attack_dir.y < SEN_45 * attack_dir.x and attack_dir.y >= -SEN_45 * attack_dir.x:
		return 3
	elif attack_dir.y >= SEN_45 * attack_dir.x and attack_dir.y >= -SEN_45 * attack_dir.x:
		return 4
	return 0

	
# Signals

func _on_animation_player_animation_finished(anim_name):
	if anim_name.contains("attack"):
		ATTACKING = false
		attack.disable_attack()
		
		
func _on_hit_cooldown_timeout():
	INVINCILITY = false
	sprites.set_modulate(Color(1,1, 1, 1))


func _on_hitbox_damage_recieved():
	INVINCILITY = true
	hit_cooldown_timer.start()
	sprites.set_modulate(Color(218,104, 97, 1))



func _on_attack_cooldown_timeout():
	SPEED = BASE_SPEED
	ATTACK_COOLDOWN = false
