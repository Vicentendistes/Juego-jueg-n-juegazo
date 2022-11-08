extends Node2D

func _enter_tree():
	if Global.respawn:
		$Charlie.global_position = Global.respawn
	if not Global.time_on:
		Global.time = 0
		Global.time_on = true
