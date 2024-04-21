class_name Player
extends BaseCreature


var BASE_SPEED = 5000.0

var SEN_45 = pow(2, 1/2)/2

@onready var animation := $Player as AnimationPlayer
@onready var sprites := $Sprites as Sprite2D
@onready var hit_cooldown_timer := $HitCooldown as Timer
@onready var attack_cooldown_timer := $AttackCooldown as Timer
@onready var attack := $Attack as PlayerAttackComponent

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
			sprites.scale.x = DIR.x
		if velocity != Vector2.ZERO:
			animation.play("running")
		else:
			animation.play("idle")
			

func attack_handler():
	
	if Input.is_action_just_pressed("attack1") and !ATTACK_COOLDOWN:
		ATTACKING = true
		SPEED = SPEED * 0.1
		ATTACK_COOLDOWN = true
		attack.enable_attack()
		var attack_direction = handle_attack_direction()
		if attack_direction == 1:
			animation.play("attack1_up")
			sprites.scale.x = 1
		elif attack_direction == 2:
			animation.play("attack1_side_left")
		elif attack_direction == 3:
			animation.play("attack1_side_right")
		elif attack_direction == 4:
			animation.play("attack1_down")
			sprites.scale.x = 1
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
	if anim_name.contains("attack1"):
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
