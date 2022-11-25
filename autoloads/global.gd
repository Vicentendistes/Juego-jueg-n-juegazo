extends Node

#respawn position
var respawn = null
#current activate respawn
var active_respawn = null

var time = 0
var time_on = false
var time_show = false #mostrar el tiempo
var time_visible = false

func _process(delta):
	if time_on:
		time += delta
		if time_show:
			time_visible = true
		else:
			time_visible = false
	else:
		time_visible = false
		time = 0
