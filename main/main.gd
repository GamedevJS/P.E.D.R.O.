class_name Main
extends Node2D


@export var player : Player
@export var ui : UI


func _ready():
	if !player.item_collected.is_connected(ui._on_collect):
		player.item_collected.connect(ui._on_collect)
