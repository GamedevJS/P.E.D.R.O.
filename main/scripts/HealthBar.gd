extends ProgressBar


@onready var timer := $Timer as Timer
@onready var damage_bar := $DamageBar as ProgressBar

var health_component : HealthComponent

var HEALTH : float = 0.0

func _ready():
	var parent : BaseCreature = get_parent()
	health_component = parent.get_node("HealthComponent")
	HEALTH = health_component.HEALTH
	
	value = HEALTH
	max_value = HEALTH
	
	damage_bar.value = HEALTH
	damage_bar.max_value = HEALTH
	
	
func findByClass(node: Node, className : String):
	for child in node.get_children():
		print(child)
		if child.is_class(className):
			return child


func _on_timer_timeout():
	damage_bar.value = HEALTH


func _on_health_component_damage_recieved():
	var prev_health = HEALTH
	HEALTH = health_component.HEALTH
	value = HEALTH
	
	if HEALTH <= 0:
		queue_free()
		
	if HEALTH < prev_health:
		timer.start()
	else:
		damage_bar.value = HEALTH
