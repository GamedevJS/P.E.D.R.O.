class_name UI
extends CanvasLayer

@onready var score_label := %Score as Label

var score : int = 0:
	set(new_score):
		score = new_score

func _process(delta):
	_update_score()


func _update_score():
	score_label.text = str(score)


func _on_collect(collectable: Collectable):
	score += collectable.points
	collectable.queue_free()
	
	
	
	
	
	
	
	
	
	
