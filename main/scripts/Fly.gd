class_name Fly
extends BaseEnemy

var BASE_SPEED : float = 2000.0

@onready var spit_attack = load("res://main/scenes/projectiles/Spit.tscn")

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
		if ATTACKING and !ATTACK_COOLDOWN:
			attack()
		else:
			animation.play("fly")
	else:
		animation.play("hurt")


func attack():
	animation.play("attack")
	attack_cooldown.start()
	ATTACK_COOLDOWN = true
	var spit : Spit = spit_attack.instantiate()
	
	var target_pos = (PLAYER.position - position).normalized()
	if target_pos.x >= 0:
		sprites.scale.x = -1
		spit.position = position + Vector2(15,0)
	else:
		sprites.scale.x = 1
		spit.position = position + Vector2(-15,0)
	
	spit.ATTACK_DIR = target_pos
	get_parent().add_child(spit)


func _on_hitbox_component_damage_recieved():
	INVINCILITY = true
	hit_cooldown.start()


func _on_invincibility_timer_timeout():
	INVINCILITY = false


func _on_attack_cooldown_timeout():
	ATTACK_COOLDOWN = false
