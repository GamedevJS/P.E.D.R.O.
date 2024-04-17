class_name Player
extends CharacterBody2D

var STATS = {
	speed = 5000,
	health = 100
}

var SPEED;
var DIR : Vector2 = Vector2.ZERO
var ATTACKING : bool = false
var IS_ALIVE = true
var HEALTH;
var INVINCILITY = false
var UNDER_ATTACK : bool = false

@onready var animation := $Player as AnimationPlayer
@onready var sprites := $Sprites as Sprite2D
@onready var hit_cooldown_timer := $HitCooldown as Timer


func _ready():
	SPEED = STATS.speed
	HEALTH = STATS.health
	
	
func _physics_process(delta):
	movment_handler(delta)
	move_and_slide()
	

func _process(delta):
	animation_handler()	


func damage_handler():
	if UNDER_ATTACK:
		print("enemy hit")
		


func movment_handler(delta):
	DIR = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	velocity = DIR * SPEED * delta
	

func animation_handler():
	if DIR.x != 0:
		sprites.scale.x = DIR.x
	if ATTACKING == false:
		if velocity != Vector2.ZERO:
			animation.play("running")
		else:
			animation.play("idle")
	if Input.is_action_just_pressed("attack1"):
		ATTACKING = true
		SPEED = SPEED * 0.1
		if DIR.y == -1:
			animation.play("attack1_up")
		elif DIR.y == 1:
			animation.play("attack1_down")
		else:
			animation.play("attack1_side")


# Signals

func _on_animation_player_animation_finished(anim_name):
	if anim_name.contains("attack1"):
		ATTACKING = false
		SPEED = STATS.speed

