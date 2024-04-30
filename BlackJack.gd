extends Sprite2D

@export var Deck = []
@export var Empty_card : PackedScene
var cardTexture = [
	"res://Sprites/card_hearts_A.png", "res://Sprites/card_hearts_02.png", "res://Sprites/card_hearts_03.png", 
	"res://Sprites/card_hearts_04.png", "res://Sprites/card_hearts_05.png", "res://Sprites/card_hearts_06.png", 
	"res://Sprites/card_hearts_07.png", "res://Sprites/card_hearts_08.png", "res://Sprites/card_hearts_09.png", 
	"res://Sprites/card_hearts_10.png", "res://Sprites/card_hearts_J.png", "res://Sprites/card_hearts_Q.png", 
	"res://Sprites/card_hearts_K.png",
	"res://Sprites/card_diamonds_A.png", "res://Sprites/card_diamonds_02.png", "res://Sprites/card_diamonds_03.png", 
	"res://Sprites/card_diamonds_04.png", "res://Sprites/card_diamonds_05.png", "res://Sprites/card_diamonds_06.png", 
	"res://Sprites/card_diamonds_07.png", "res://Sprites/card_diamonds_08.png", "res://Sprites/card_diamonds_09.png", 
	"res://Sprites/card_diamonds_10.png", "res://Sprites/card_diamonds_J.png", "res://Sprites/card_diamonds_Q.png", 
	"res://Sprites/card_diamonds_K.png",
	"res://Sprites/card_clubs_A.png", "res://Sprites/card_clubs_02.png", "res://Sprites/card_clubs_03.png", 
	"res://Sprites/card_clubs_04.png", "res://Sprites/card_clubs_05.png", "res://Sprites/card_clubs_06.png", 
	"res://Sprites/card_clubs_07.png", "res://Sprites/card_clubs_08.png", "res://Sprites/card_clubs_09.png", 
	"res://Sprites/card_clubs_10.png", "res://Sprites/card_clubs_J.png", "res://Sprites/card_clubs_Q.png", 
	"res://Sprites/card_clubs_K.png",
	"res://Sprites/card_spades_A.png", "res://Sprites/card_spades_02.png", "res://Sprites/card_spades_03.png", 
	"res://Sprites/card_spades_04.png", "res://Sprites/card_spades_05.png", "res://Sprites/card_spades_06.png", 
	"res://Sprites/card_spades_07.png", "res://Sprites/card_spades_08.png", "res://Sprites/card_spades_09.png", 
	"res://Sprites/card_spades_10.png", "res://Sprites/card_spades_J.png", "res://Sprites/card_spades_Q.png", 
	"res://Sprites/card_spades_K.png"
]
var Card_name = []
var suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
var ranks = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
var texture_ref = preload("res://icon.svg")
# Called when the node enters the scene tree for the first time.
var Random_cards = null
func _ready():
	#for texture_load in cardTexture:
		#load(texture_load)
	for suit in suits:
		for rank in ranks:
			var cardname = rank + "_of_" + suit
			Card_name.append(cardname)
	print(Card_name)
	#print("I am ready")
	#print(Random_cards)
	
	for card in 52:
		var new_resource = CardData.new()
		if card in range(1,13):
			new_resource.Card_Name = Card_name[card]
			print(cardTexture[card])
			new_resource.Card_Image = load(cardTexture[card])
			print(new_resource.Card_Name)
			if "Ace" in new_resource.Card_Name:
				new_resource.Card_value = 11
				print(new_resource.Card_value)
			elif card % 13 +1 >= 11:
				new_resource.Card_value =10
				print(new_resource.Card_value)
			else: 
				new_resource.Card_value = card %  13 + 1
				print(new_resource.Card_value)
			#i need to put all the card names in a table and all the card textures in another table

		Deck.append(new_resource)
	Random_cards = Deck.duplicate()
	game_start(2)
	#print(Deck)
	#Instance_card.card_data = random_suit
	#get_node(".").add_child(Instance_card)
	#Instance_card.global_position = Vector2(213,161)
	#print(random_suit.Card_Name)
	#Instance_card.card_data = random_suit
	#Instance_card.card_data.Card_Name = random_suit.CardData.Card_Name

#func _process(delta):
	#if Input.is_key_pressed(KEY_SPACE):
		#game_start(6)



func game_start(players:int):
	var CardPos = get_parent().position + Vector2(-122,-140)
	for ply in players:
		#print("I am a player")
		var random_suit = Random_cards.pick_random()
		
		var Instance_card = Empty_card.instantiate()
		Instance_card.card_data = random_suit
		get_node(".").add_child(Instance_card)
		Instance_card.position = CardPos
		#print(random_suit.Card_Name)
		Instance_card.card_data = random_suit
		CardPos = CardPos + Vector2(122,0)
		
	##print(CardPos)

func card_spawn():
	pass

		
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#pass
