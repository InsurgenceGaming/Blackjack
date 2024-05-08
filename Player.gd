extends Sprite2D


@export var control_node : Node2D
var _card_total :int
var my_turn = false
@onready var hit_button =$Button
@onready var stand_button = $Button2

func _process(delta):
	_card_total = total_value()
	if my_turn:
		hit_button.disabled = false
		stand_button.disabled = false
		if _card_total > 21:
			control_node.Next_player()
	else:
		hit_button.disabled = true
		stand_button.disabled = true
	

func total_value():
	var amount_of_ace: int = 0
	var total_card = 0
	var total_with_aces = 0
	
	# Calculate the total value of cards and count aces
	for card in get_children():
		if card.is_in_group("Ace"):
			amount_of_ace += 1
		elif card.is_in_group("Card"):
			total_card += card.my_value
	
	# Check if there are aces and adjust total value accordingly
	total_with_aces = total_card + amount_of_ace * 11
	if amount_of_ace > 0:
		if total_with_aces > 21:
			total_card += amount_of_ace * 1  # Each ace counts as 1
		else:
			total_card = total_with_aces  # Each ace counts as 11
	
	print(_card_total)
	return total_card
func _on_button_pressed():
	control_node.card_spawn(self,self.get_children()[self.get_children().size()-1].position +Vector2(45,0))
	print("I want a new card")
	



func _on_button_2_pressed():
	control_node.Next_player()
	print("I dont want a new card")
