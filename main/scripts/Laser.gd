class_name Laser
extends CharacterBody2D

@export var SPEED : float = 8000.0

var EXPLODE : bool = false
var ATTACK_DIR : Vector2 = Vector2.ZERO

@onready var animation := $AnimationPlayer as AnimationPlayer
@onready var explosion_timer := $Detonator as Timer
@onready var sprites := $Sprite2D as Sprite2D
@onready var area := $AreaAttackComponent as AreaAttackComponent

func _ready():
	explosion_timer.start()
	

func _physics_process(delta):
	if !EXPLODE:
		velocity = ATTACK_DIR * SPEED * delta
		animation.play("shoot")
		move_and_slide()


func _on_detonator_timeout():
	detonate()
	
	
func detonate():
	area.enable_explosion()
	sprites.set_visible(true)
	EXPLODE = true
	animation.play("finish")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "finish":
		queue_free()


func _on_collision_body_entered(body):
	explosion_timer.stop()
	detonate()
	
