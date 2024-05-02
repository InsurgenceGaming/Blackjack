extends Sprite2D


@export var control_node : Node2D
var _card_total :int
var my_turn = false
@onready var hit_button =$Button
@onready var stand_button = $Button2
signal End_turn()
func _ready():
	print(self)
func _process(delta):
	_card_total = total_value()
	if my_turn:
		hit_button.disabled = false
		stand_button.disabled = false
		print(_card_total)
		if _card_total > 21:
			control_node.Next_player()
	else:
		hit_button.disabled = true
		stand_button.disabled = true
	
func total_value():
	var total_card = 0
	for card in get_children():
		if card.is_in_group("Card"):
			total_card += card.my_value
	return total_card
func _on_button_pressed():
	control_node.card_spawn(self)
	print("I want a new card")
	



func _on_button_2_pressed():
	control_node.Next_player()
	print("I dont want a new card")
