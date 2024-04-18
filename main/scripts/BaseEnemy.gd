class_name BaseEnemy
extends CharacterBody2D

var STATS = {
	speed = 2500,
	health = 50,
 	damage = 10
}

var SPEED
var HEALTH
var DIR : Vector2 = Vector2.ZERO
var ATTACKING : bool = false
var ATTACK_COOLDOWN : bool = false
var IS_ALIVE = true
var CHASE = false
var PLAYER : CharacterBody2D = null
var UNDER_ATTACK : bool = false
var DAMAGE = 0

@onready var animation := $Player as AnimationPlayer
@onready var sprites := $Sprites as Sprite2D
@onready var detection_area := $DetectionArea as Area2D
@onready var attack_cooldown := $AttackCooldown as Timer



func _ready():
	SPEED = STATS.speed
	HEALTH = STATS.health
	DAMAGE = STATS.damage
