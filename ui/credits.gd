extends MarginContainer


func _ready():
	pass

func _input(event):
	if event.is_action_pressed("quit"):
		SceneTransition.change_scene("res://ui/main_menu.tscn")
