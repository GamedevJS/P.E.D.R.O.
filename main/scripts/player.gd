extends CharacterBody2D

var SPEED = 100.0
var DIR : Vector2 = Vector2.ZERO

@onready var animated_sprites := $Sprites as AnimatedSprite2D

func _ready():
	pass

func _physics_process(delta):
	DIR = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	velocity = DIR * SPEED
	move_and_slide()

func _process(delta):
	animation_handler()

func animation_handler():
	if velocity != Vector2.ZERO:
		if velocity.x > 0:
			animated_sprites.play("running")
			animated_sprites.set_flip_h(false)
		else:
			animated_sprites.play("running")
			animated_sprites.set_flip_h(true)
	else:
		animated_sprites.play("idle")
	
	if Input.is_action_just_pressed("attack1"):
		animated_sprites.play("attack1_side")
		
	
