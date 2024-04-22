class_name BaseEnemy
extends BaseCreature


var CHASE = false
var PLAYER : CharacterBody2D = null


@onready var animation := $Player as AnimationPlayer
@onready var sprites := $Sprites as Sprite2D
@onready var attack_cooldown := $AttackCooldown as Timer
@onready var hit_cooldown := $InvincibilityTimer as Timer
@onready var attack_component := $AttackComponent as EnemyAttackComponent


func movment_handler(delta):
	if CHASE and !ATTACKING:
		DIR = (PLAYER.position - position).normalized()
		velocity = (DIR * SPEED * delta)
		if INVINCILITY:
			velocity -= KNOCKBACK
	else:
		velocity = Vector2.ZERO
