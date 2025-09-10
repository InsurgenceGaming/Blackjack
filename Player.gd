extends Sprite2D


@export var control_node : Node2D
var _card_total :int
var my_turn = false
@onready var hit_button =$Button
@onready var stand_button = $Button2
<<<<<<< Updated upstream
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
=======

func _ready() -> void:
	var players = get_tree().get_nodes_in_group("Player")
	if players.size() > 1:
		var last_player = players[players.size() - 2] # get the player before this one
		position = last_player.position + Vector2(130, 0)
>>>>>>> Stashed changes
	else:
		position = Vector2(100, 500) # first player spawn
func _enter_tree() -> void:
	set_multiplayer_authority(name.to_int())
func _process(delta):
	if is_multiplayer_authority():
		if Input.is_key_pressed(KEY_ESCAPE):
			$"../".exit_game(name.to_int())
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
	var total_card = 0
	for card in get_children():
		if card.is_in_group("Card"):
			total_card += card.my_value
<<<<<<< Updated upstream
=======
	
	# Check if there are aces and adjust total value accordingly
	total_with_aces = total_card + amount_of_ace * 11
	if amount_of_ace > 0:
		if total_with_aces > 21:
			total_card += amount_of_ace * 1  # Each ace counts as 1
		else:
			total_card = total_with_aces  # Each ace counts as 11
	
	#print(_card_total,"test")
>>>>>>> Stashed changes
	return total_card
func _on_button_pressed():
	control_node.card_spawn(self)
	print("I want a new card")
	



func _on_button_2_pressed():
	control_node.Next_player()
	print("I dont want a new card")
