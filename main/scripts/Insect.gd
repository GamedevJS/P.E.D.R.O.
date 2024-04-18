class_name Insect
extends BaseEnemy


func _physics_process(delta):
	movment_handler(delta)
	attack_handler()
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


func attack_handler():
	if PLAYER != null and ATTACKING:
		if !ATTACK_COOLDOWN:
			var damege_func = Callable(PLAYER, "recieve_damage")
			damege_func.call(DAMAGE)
			ATTACK_COOLDOWN = true
			attack_cooldown.start()

func recieve_damage(damage: int):
	HEALTH -= damage
	print(HEALTH)
	if HEALTH <= 0:
		on_death()
		

func on_death():
	print(name + " died")
	self.queue_free()

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
