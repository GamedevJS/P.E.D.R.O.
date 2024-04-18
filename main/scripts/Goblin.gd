class_name Goblin
extends BaseEnemy


func _physics_process(delta):
	movment_handler(delta)
	attack_handler()
	move_and_slide()


func movment_handler(delta):
	if CHASE and !ATTACKING:
		DIR = (PLAYER.position - position).normalized()
		velocity = DIR * SPEED * delta
	else:
		velocity = Vector2.ZERO


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
			

func attack_handler():
	if PLAYER != null and ATTACKING:
		if !ATTACK_COOLDOWN:
			var damege_func = Callable(PLAYER, "recieve_damage")
			damege_func.call(DAMAGE)
			ATTACK_COOLDOWN = true
			attack_cooldown.start()


### Signals

func _on_detection_area_body_entered(body):
	PLAYER = body
	CHASE = true

func _on_detection_area_body_exited(body):
	PLAYER = null
	CHASE = false




func _on_hitbox_body_entered(body):
	if body is Player:
		ATTACKING = true
	

func _on_hitbox_body_exited(body):
	ATTACKING = false


func _on_attack_cooldown_timeout():
	ATTACK_COOLDOWN = false
