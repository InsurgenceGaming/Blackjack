extends Node2D

var Players = []
# Called when the node enters the scene tree for the first time.

func _ready():
	print(get_tree().get_nodes_in_group("Player"))
	



# Called every frame. 'delta' is the elapsed time since the previous frame.r

