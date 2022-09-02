extends Node2D


export (PackedScene) var Ball

func _input(event):
	if event.is_action_pressed("click"):
		var new_ball = Ball.instance()
		new_ball.position = get_global_mouse_position()#get_viewport().get_mouse_position()
		add_child(new_ball)
