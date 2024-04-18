class_name HitboxComponent
extends Area2D

signal damage_recieved

@export var HEALT_COMPONENT : HealthComponent

func on_hit(damage: float):
	if HEALT_COMPONENT != null:
		HEALT_COMPONENT.handle_damage(damage)
		damage_recieved.emit()
