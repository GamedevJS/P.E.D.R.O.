class_name Insect
extends BaseEnemy

var BASE_SPEED : float = 2500.0

func _init():
	SPEED = BASE_SPEED

func _physics_process(delta):
	movment_handler(delta)
	move_and_slide()


func _process(delta):
	if DIR.x > 0:
		sprites.scale.x = -1
	elif DIR.x < 0:
		sprites.scale.x = 1
		
	if !ATTACKING:
		if velocity != Vector2.ZERO:
			animation.play("run")
		else:
			animation.stop()
	else:
		animation.play("attack")


func movment_handler(delta):
	if CHASE and !ATTACKING:
		DIR = (PLAYER.position - position).normalized()
		velocity = DIR * SPEED * delta
	else:
		velocity = Vector2.ZERO


func _on_attack_cooldown_timeout():
	ATTACK_COOLDOWN = false
