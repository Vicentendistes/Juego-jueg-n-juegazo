extends Node

var respawn = null

var levels = []
var current_level = null

var time = 0
var time_on = false
var time_show = false

func _process(delta):
	if time_on:
		time += delta
	else:
		time = 0
