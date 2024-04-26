class_name Main
extends Node2D


@onready var spawner : EnemySpawner = get_node("Map/EnemySpawner")
	
@export var player : Player
@export var ui : UI


func _ready():
	if !player.item_collected.is_connected(ui._on_collect):
		player.item_collected.connect(ui._on_collect)

	if !player.player_died.is_connected(ui.handle_player_death_ui):
		player.player_died.connect(ui.handle_player_death_ui)

	if !player.player_died.is_connected(handle_player_death):
		player.player_died.connect(handle_player_death)

	spawner.enable()
	

func handle_player_death(status: Player.PlayerStatus):
	var camera : Camera2D = $Camera
	camera.position = status.position
	camera.make_current()
	spawner.disable()


func on_start():
	player.initialize()
	spawner.enable()
	
