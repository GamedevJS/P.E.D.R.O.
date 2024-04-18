class_name PlayerAttackComponent
extends Area2D

@export var DAMAGE : float
@export var KNOCK_BACK_FORCE : float

@onready var PLAYER : Player = get_parent()
@onready var attack_area := $AttackArea as CollisionShape2D


func _on_area_entered(area):
	if area.get_parent() is BaseEnemy:
		var target : HitboxComponent = area
		PLAYER.ATTACKING = true
		target.on_hit(DAMAGE)
		PLAYER.ATTACK_COOLDOWN = true
		PLAYER.attack_cooldown_timer.start()


func enable_attack():
	self.set_monitoring(true)


func disable_attack():
	self.set_monitoring(false)
