extends CharacterBody2D

var SPEED = 5000.0
var DIR : Vector2 = Vector2.ZERO
var ATTACKING : bool = false
var IS_ALIVE = true
var HEALTH = 100
var HIT_COOLDOWN = false

@onready var animation := $Player as AnimationPlayer
@onready var sprites := $Sprites as Sprite2D
@onready var hit_cooldown_timer := $HitCooldown as Timer

var enemy : CharacterBody2D = null

	
func _physics_process(delta):
	DIR = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	velocity = DIR * SPEED * delta
	
	if !IS_ALIVE:
		print("you died")
		queue_free()
		
	move_and_slide()

func _process(delta):
	animation_handler()


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
		SPEED = 1000.0
		if DIR.y == -1:
			animation.play("attack1_up")
		elif DIR.y == 1:
			animation.play("attack1_down")
		else:
			animation.play("attack1_side")
	if Input.is_action_just_pressed("attack2"):
		IS_ALIVE = false
		animation.play("die")

func _on_animation_player_animation_finished(anim_name):
	if anim_name.contains("attack1"):
		ATTACKING = false
		SPEED = 5000.0


func _on_hitbox_body_entered(body):
	print(body)
	if body.has_method("attack"):
		print("enemy detected")
		HIT_COOLDOWN = true
		hit_cooldown_timer.start()

func _on_hit_cooldown_timeout():
	HIT_COOLDOWN = false # Replace with function body.
