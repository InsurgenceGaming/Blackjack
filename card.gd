extends Sprite2D
@export var card_data:CardData
var my_value
var my_name
func _ready():
	#print("i am ready")
	texture = card_data.Card_Image
	my_name = card_data.Card_Name
	my_value = card_data.Card_value
	
