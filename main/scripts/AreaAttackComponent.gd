class_name AreaAttackComponent
extends Area2D

@export var DAMAGE : float
@export var KNOCK_BACK_FORCE : float
@export var DURATION : float

@onready var area := $Area as CollisionShape2D

func enable_explosion():
	area.set_disabled(false)
	

func _on_area_entered(area):
	print("something was hit: " + area.get_parent().name)
	if area is HitboxComponent:
		var attack_dir : Vector2 = (get_parent().position - area.position).normalized()
		var knockback = attack_dir * KNOCK_BACK_FORCE
		print(knockback)
		area.on_hit(DAMAGE, knockback, DURATION)
