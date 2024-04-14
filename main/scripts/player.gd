extends CharacterBody2D

const SPEED = 100.0
var DIR : Vector2 = Vector2.ZERO

const MOVING = "parameters/conditions/MOVING"
const IDLE = "parameters/conditions/IDLE"
const ATTACKING = "parameters/conditions/ATTACKING"
const DEAD = "parameters/conditions/DEAD"

const MOVING_BLEND_POS = "parameters/walking/blend_position"
const IDLE_BLEND_POS = "parameters/idle/blend_position"
const ATTACKING_BLEND_POS = "parameters/attack1/blend_position"
const DEAD_BLEND_POS = "parameters/dead/blend_position"


@onready var animation := $sprites as AnimatedSprite2D
@onready var animation_tree := $AnimationTree as AnimationTree

func _ready():
	animation_tree.active = true
	animation_tree[DEAD] = false

func _physics_process(delta):
	
	DIR = Vector2(
		Input.get_action_strength("right") - Input.get_action_strength("left"),
		Input.get_action_strength("down") - Input.get_action_strength("up")
	)
	velocity = DIR * SPEED
	move_and_slide()

func _process(delta):
	animation_handler()

func animation_handler():
	
	if velocity != Vector2.ZERO:
		animation_tree[MOVING] = true
		animation_tree[IDLE] = false
	else:
		animation_tree[MOVING] = false
		animation_tree[IDLE] = true
	
	if Input.is_action_just_pressed("attack1"):
		animation_tree[ATTACKING] = true
	else:
		animation_tree[ATTACKING] = false
		
	animation_tree[IDLE_BLEND_POS] = DIR
	animation_tree[MOVING_BLEND_POS] = DIR
	animation_tree[ATTACKING_BLEND_POS] = DIR
