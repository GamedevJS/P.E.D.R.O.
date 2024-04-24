class_name EnemySpawner
extends Node2D

@export var SPAWNS : Array[SpawnInfo] = []

@onready var PLAYER = get_tree().get_first_node_in_group("player")

var time = 0

func _on_timer_timeout():
	time += 1
	var enemy_spawns = SPAWNS
	for spawner in enemy_spawns:
		if (time >= spawner.time_start) and (time <= spawner.time_end):
			if spawner.spawn_delay_counter < spawner.enemy_spawn_delay:
				spawner.spawn_delay_counter += 1
			else:
				spawner.spawn_delay_counter = 0
				var enemy = load(str(spawner.enemy._path))
