class_name HealthComponent
extends Node2D

signal damage_recieved

@export var MAX_HEALTH = 100.0
var HEALTH: float

func _ready():
	HEALTH = MAX_HEALTH
	

func handle_damage(damage: float):
	HEALTH -= damage
	damage_recieved.emit()
	if HEALTH <= 0:
		get_parent().on_death()
