class_name HealthComponent
extends Node2D

@export var MAX_HEALTH = 100.0
var HEALTH: float

func _ready():
	HEALTH = MAX_HEALTH
	

func handle_damage(damage: float):
	HEALTH -= damage
	print(HEALTH)
	if HEALTH <= 0:
		get_parent().queue_free()
		print(get_parent().name + " just died")
