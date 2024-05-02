extends Sprite2D


var card_total :int
var my_turn = false
@onready var hit_button =$Button
@onready var stand_button = $Button2
func _process(delta):
	if card_total > 21:
		get_node("/root/Control").Next_player()
	if my_turn:
		hit_button.disabled = false
		stand_button.disabled = false
	else:
		hit_button.disabled = true
		stand_button.disabled = true

func _on_button_pressed():
	get_node("/root/Control").card_spawn(self)
	print("I want a new card")
	



func _on_button_2_pressed():
	get_node("/root/Control").Next_player()
	print("I dont want a new card")
