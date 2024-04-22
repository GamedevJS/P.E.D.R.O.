class_name Laser
extends CharacterBody2D

@export var SPEED : float = 8000.0

var EXPLODE : bool = false
var DIR : float
var SPAWN_POS : Vector2
var SPAWN_ROT : Vector2

@onready var animation := $AnimationPlayer as AnimationPlayer
@onready var explosion_timer := $Detonator as Timer
@onready var sprites := $Sprite2D as Sprite2D


func _ready():
	explosion_timer.start()
	

func _physics_process(delta):
	if !EXPLODE:
		velocity = Vector2(0, -SPEED).rotated(DIR) * delta
		animation.play("shoot")
		move_and_slide()


func _on_detonator_timeout():
	sprites.set_visible(true)
	EXPLODE = true
	animation.play("finish")


func _on_animation_player_animation_finished(anim_name):
	if anim_name == "finish":
		queue_free()
