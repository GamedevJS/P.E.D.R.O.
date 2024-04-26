extends ProgressBar


@onready var timer := $Timer as Timer
@onready var damage_bar := $DamageBar as ProgressBar

var health_component : HealthComponent

var HEALTH : float = 0.0

func _ready():
	var palyer_char : Player = get_parent().get_parent().get_parent().get_node("player")
	print(palyer_char)
	health_component = palyer_char.get_node("HealthComponent")
	HEALTH = health_component.HEALTH
	
	print(health_component)
	print(health_component.HEALTH)
	print(HEALTH)
	print(value)
	print(max_value)
	
	set_value(HEALTH)
	set_max(HEALTH)
	damage_bar.value = HEALTH
	damage_bar.max_value = HEALTH
	
	if !health_component.damage_recieved.is_connected(_on_health_component_damage_recieved):
		health_component.damage_recieved.connect(_on_health_component_damage_recieved)
	
	
func _on_timer_timeout():
	damage_bar.value = HEALTH


func _on_health_component_damage_recieved():
	var prev_health = HEALTH
	HEALTH = health_component.HEALTH
	set_value(HEALTH)
	
	print("HEALTH " + str(HEALTH))
	print("value " + str(value))
	
	if HEALTH <= 0:
		queue_free()
		
	if HEALTH < prev_health:
		timer.start()
	else:
		damage_bar.value = HEALTH
