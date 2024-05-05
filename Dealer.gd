extends Sprite2D
var my_turn = false
var _card_total :int
@export var control_node : Node2D



func _process(delta):
	_card_total = total_value()
	if my_turn:
		if _card_total >= 15:
			control_node.Next_player()
		else:
			print(_card_total)
			control_node.card_spawn(self,self.get_children()[self.get_children().size()-1].position +Vector2(45,0))

func total_value():
	var total_card = 0
	for card in get_children():
		if card.is_in_group("Card"):
			total_card += card.my_value
	return total_card
