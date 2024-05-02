extends Node2D
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
var active_player
var suits = ["Hearts", "Diamonds", "Clubs", "Spades"]
var ranks = ["Ace", "Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King"]
# Called when the node enters the scene tree for the first time.
var Random_cards = null
func _ready():
	var player_nodes = get_tree().get_nodes_in_group("Player")
	for player_node in player_nodes:
		TurnManager.Players.append(player_node)
	
	print(TurnManager.Players)
	
	for suit in suits:
		for rank in ranks:
			var cardname = rank + "_of_" + suit
			Card_name.append(cardname)
	
	for card in 52:
		var new_resource = CardData.new()
		new_resource.Card_Name = Card_name[card]
		new_resource.Card_Image = load(cardTexture[card])
		if "Ace" in new_resource.Card_Name:
			new_resource.Card_value = 11
		elif card % 13 +1 >= 11:
			new_resource.Card_value =10
		else: 
			new_resource.Card_value = card %  13 + 1
		Deck.append(new_resource)
	Random_cards = Deck.duplicate()
	#print(Random_cards)
	game_start(TurnManager.Players.size())
	initialized()
var CardPos
func game_start(Players:int):
	for ply in TurnManager.Players:
		CardPos = position + Vector2(-30,-100)
		for test in range(2):
			card_spawn(ply)
			



func card_spawn(card_owner):
	var random_suit = Random_cards.pick_random()
	var Instance_card = Empty_card.instantiate()
	Instance_card.card_data = random_suit
	Instance_card.position = CardPos
	Instance_card.card_data = random_suit
	card_owner.add_child(Instance_card)
	card_owner.card_total += Instance_card.my_value
	print(CardPos)
	CardPos = CardPos + Vector2(45,0)
	Random_cards.erase(random_suit)
	pass

func initialized():
	active_player = TurnManager.Players[0]
	active_player.modulate = Color(0,1,0)
	active_player.my_turn = true
	print(active_player)
func Next_player():
	var  new_index : int =( active_player.get_index()+1) % get_child_count()
	active_player.my_turn = false
	active_player = get_child(new_index)
	active_player.my_turn = true
	active_player.modulate = Color(1,0,0)
	print(new_index)

func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		Next_player()
