class_name UI
extends CanvasLayer

@onready var score_label := %Score as RichTextLabel
@onready var death_label := %DeathText as RichTextLabel

@onready var game_layout := %GameLayout as VBoxContainer
@onready var death_layout := %DeathLayout as VBoxContainer

var score : int = 0:
	set(new_score):
		score = new_score

func _ready():
	var font : Font = load("res://assets/fonts/robtronika-font/Robtronika-4Bq8p.ttf")
	score_label.push_font(font, 100)
	death_label.push_font(font, 100)
	death_layout.set_visible(false)
	

func _on_collect(collectable: Collectable):
	score += collectable.points
	collectable.queue_free()
	_update_score()
	
	
func _update_score():
	var new_score = "Score: " + str(score)
	#var new_score = "[font=" + font_resource + "]Score: " + str(score) + "[/font]"
	score_label.clear()
	score_label.append_text(new_score)
	
	
func handle_player_death_ui(status: Player.PlayerStatus):
	game_layout.set_visible(false)
	death_layout.set_visible(true)
	death_label.append_text("[indent]Your score was " + str(score) + "[/indent]")
	
	
	
	
	
	
