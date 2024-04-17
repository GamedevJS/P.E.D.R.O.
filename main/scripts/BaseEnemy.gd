class_name BaseEnemy
extends CharacterBody2D

var STATS = {
	speed = 2500,
	health = 50,
 	damage = 10
}

var SPEED
var HEALTH
var DIR : Vector2 = Vector2.ZERO
var ATTACKING : bool = false
var IS_ALIVE = true
var CHASE = false
var IN_RANGE = false
var PLAYER : CharacterBody2D = null
var UNDER_ATTACK : bool = false
var DAMAGE = 0

@onready var animation := $Player as AnimationPlayer
@onready var sprites := $Sprites as Sprite2D
@onready var detection_area := $DetectionArea as Area2D



func _ready():
	SPEED = STATS.speed
	HEALTH = STATS.health
	DAMAGE = STATS.damage


func _process(delta):
	animation_handler()


func animation_handler():
	if DIR.x > 0:
		sprites.scale.x = 1
	elif DIR.x < 0:
		sprites.scale.x = -1
	if ATTACKING == false:
		if velocity != Vector2.ZERO:
			animation.play("running")
		else:
			animation.play("idle")
