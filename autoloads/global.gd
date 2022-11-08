extends Node

var respawn = null

var levels = []
var current_level = null

var time = 0
var time_on = false
func _process(delta):
	if time_on:
		time += delta
