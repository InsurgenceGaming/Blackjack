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
var dealer = null
# Called when the node enters the scene tree for the first time.
var Random_cards = null
func _ready():
	var player_nodes = get_tree().get_nodes_in_group("Player")
	for player_node in player_nodes:
		TurnManager.Players.append(player_node)
	for player in get_tree().get_nodes_in_group("Dealer"):
		TurnManager.Players.append(player)
		
	
	#if player_nodes == get_tree().get_nodes_in_group("Dealer"):
		#TurnManager.Players.append(get_tree().get_nodes_in_group("Dealer"))
	
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
	Random_cards.shuffle()
	#print(Random_cards)
	game_start(TurnManager.Players.size())
	initialized()
var CardPos
func game_start(Players:int):
	for ply in TurnManager.Players:
		CardPos = position + Vector2(-30,-100)
		for test in range(2):
			card_spawn(ply,CardPos)
			



func card_spawn(card_owner,card_pos):
	var random_suit = Random_cards.pick_random()
	var Instance_card = Empty_card.instantiate()
	Instance_card.card_data = random_suit
	Instance_card.position = card_pos
	Instance_card.card_data = random_suit
	card_owner.add_child(Instance_card)
	
	print(CardPos)
	CardPos = CardPos + Vector2(45,0)
	Random_cards.erase(random_suit)
	pass

func initialized():
	active_player = TurnManager.Players[0]
	active_player.my_turn = true
	#print(TurnManager.Players.size())


func Next_player():
	active_player.my_turn = false
	#print(active_player,active_player.my_turn)
	var  new_index : int =wrapi(TurnManager.Players.find(active_player)+1, 0, TurnManager.Players.size())
	active_player = TurnManager.Players[new_index]
	#print(new_index)
	active_player.my_turn = true
	#print("the current player is ", active_player , "at " , str(Time.get_time_dict_from_system()) )
	if new_index == 0:
		Round_Over()

func Round_Over():
	
	print("The game is over")
	
	for players in TurnManager.Players:
		if players._card_total > TurnManager.Players[TurnManager.Players.size()-1]._card_total and players._card_total < 21:
			print(players.name,"you win!")
		

	
func _process(delta):
	if Input.is_action_just_pressed("ui_right"):
		Next_player()
