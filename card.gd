extends Sprite2D
@export var card_data:CardData
var my_value
var my_name
func _ready():
	#print("i am ready")
	texture = card_data.Card_Image
	my_name = card_data.Card_Name
	my_value = card_data.Card_value
	print(my_name)
	if my_name.find("Ace") != -1:
		add_to_group("Ace")
		print(my_name)
