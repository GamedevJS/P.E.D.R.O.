class_name Spit
extends CharacterBody2D

@export var SPEED : float = 1000.0

var HIT : bool = false
var ATTACK_DIR : Vector2 = Vector2.ZERO

@onready var animation := $AnimationPlayer as AnimationPlayer
@onready var area := $RangedAttackComponent as RangedAttackComponent

func _physics_process(delta):
	if !HIT:
		velocity = ATTACK_DIR * SPEED * delta
		move_and_slide()



func _on_ranged_attack_component_area_entered(area):
	queue_free()
