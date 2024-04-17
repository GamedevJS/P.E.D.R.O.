class_name Goblin
extends BaseEnemy


func _physics_process(delta):
	movment_handler(delta)
	attack_handler()
	move_and_slide()


func movment_handler(delta):
	if CHASE and !IN_RANGE:
		DIR = (PLAYER.position - position).normalized()
		#velocity = DIR * SPEED * delta
	else:
		velocity = Vector2.ZERO


func attack_handler():
	if PLAYER != null and ATTACKING:
		print("hit")
		


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
