class_name Fly
extends BaseEnemy

var BASE_SPEED : float = 2000.0

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
	
	if !INVINCILITY:
		if !ATTACKING and !ATTACK_COOLDOWN:
			print("a")
			animation.play("fly")
		else:
			animation.play("attack")
	else:
		animation.play("hurt")


func movment_handler(delta):
	if CHASE and !ATTACKING:
		DIR = (PLAYER.position - position).normalized()
		velocity = (DIR * SPEED * delta)
		if INVINCILITY:
			velocity -= KNOCKBACK
	else:
		velocity = Vector2.ZERO


func _on_attack_cooldown_timeout():
	ATTACK_COOLDOWN = false


func _on_hitbox_component_damage_recieved():
	INVINCILITY = true
	hit_cooldown.start()


func _on_invincibility_timer_timeout():
	INVINCILITY = false
