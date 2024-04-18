class_name EnemyAttackComponent
extends Area2D

@export var DAMAGE : float
@export var KNOCK_BACK_FORCE : float

@onready var CREATURE : BaseCreature = get_parent()

var TARGET : HitboxComponent

func _process(delta):
	if CREATURE.ATTACKING and !CREATURE.ATTACK_COOLDOWN:
		attack()
		
		
func attack():
	if TARGET != null:
		TARGET.on_hit(DAMAGE)
		CREATURE.ATTACK_COOLDOWN = true
		CREATURE.attack_cooldown.start()


func _on_hitbox_area_entered(area : Area2D):
	if area.get_parent() is Player:
		TARGET = area
		CREATURE.ATTACKING = true


func _on_area_exited(area):
	CREATURE.ATTACKING = false
