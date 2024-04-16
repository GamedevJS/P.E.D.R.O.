extends CharacterBody2D

var SPEED = 2500.0
var DIR : Vector2 = Vector2.ZERO
var ATTACKING : bool = false
var IS_ALIVE = true
var CHASE = false
var IN_RANGE = false
var PLAYER : CharacterBody2D = null

var BASE_DAMAGE = 10

@onready var animation := $Player as AnimationPlayer
@onready var sprites := $Sprites as Sprite2D
@onready var detection_area := $DetectionArea as Area2D


func _physics_process(delta):
	if CHASE and !IN_RANGE:
		DIR = (PLAYER.position - position).normalized()
		velocity = DIR * SPEED * delta
	else:
		velocity = Vector2.ZERO
	move_and_slide()

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


func _on_detection_area_body_entered(body):
	PLAYER = body
	CHASE = true

func _on_detection_area_body_exited(body):
	PLAYER = null
	CHASE = false


func attack():
	pass


func _on_hitbox_body_entered(body):
	IN_RANGE = true


func _on_hitbox_body_exited(body):
	IN_RANGE = false
