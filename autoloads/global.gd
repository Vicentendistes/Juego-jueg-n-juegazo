extends Node

var respawn = null

var levels = []
var current_level = null

var time = 0
var time_on = false
var time_show = true
var time_visible = false

func _process(delta):
	if time_on:
		time += delta
		if time_show:
			time_visible = true
	else:
		time_visible = false
		time = 0
