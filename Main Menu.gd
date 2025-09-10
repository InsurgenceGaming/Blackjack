extends Control


var peer = ENetMultiplayerPeer.new()
@export var player_scene : PackedScene
@export var Blackjack : PackedScene
var blackjackstarted = false


func _on_connect_pressed():
	peer.create_client("192.168.0.129",2276)
	multiplayer.multiplayer_peer = peer
	

func _on_host_pressed():
	peer.create_server(2276)
	multiplayer.multiplayer_peer = peer
	multiplayer.peer_connected.connect(add_player)
	add_player()
	print(peer)
func exit_game(id):
	multiplayer.peer_disconnected.connect(del_player)
	del_player(id)
	

func add_player (id = 1):
	var player = player_scene.instantiate()
	player.name = str(id)
	call_deferred("add_child",player)
	if get_tree().get_nodes_in_group("Player").size() >= 1:
		_spawn_blackjack()
		


func del_player(id):
	rpc("_del_player", id)
	
@rpc("any_peer","call_local") 
func _del_player(id):
	get_node(str(id)).queue_free()
	
func _spawn_blackjack():
	var bj = Blackjack.instantiate()
	bj.name = "Blackjack"
	call_deferred("add_child", bj)
	for p in get_tree().get_nodes_in_group("Player"):
		p.control_node = bj
	# Tell clients to also spawn Blackjack
	rpc("_spawn_blackjack_remote")


@rpc("authority", "call_local")
func _spawn_blackjack_remote():
	var bj = Blackjack.instantiate()
	bj.name = "Blackjack"
	call_deferred("add_child", bj)
	for p in get_tree().get_nodes_in_group("Player"):
		p.control_node = bj
	
