extends Node2D

func _enter_tree():
	if Global.respawn:
		$Charlie.global_position = Global.respawn
