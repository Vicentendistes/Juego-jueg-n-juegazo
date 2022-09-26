extends MarginContainer

onready var resume = $"%Resume"
onready var restart = $"%Restart"
onready var main_menu = $"%MainMenu"

func _ready():
	resume.connect("pressed", self, "_on_resume_pressed")
	restart.connect("pressed", self, "_on_restart_pressed")
	main_menu.connect("pressed", self, "_on_main_menu_pressed")
	hide()
	
func _input(event):
	if event.is_action_pressed("restart"):
		if get_tree().reload_current_scene() != OK:
			print("error al reiniciar de escena")
		
		
	if event.is_action_pressed("quit"):
		visible = !visible
		get_tree().paused = visible
		resume.grab_focus()
		
func _on_resume_pressed():
	get_tree().paused = false
	hide()
	
func _on_restart_pressed():
	get_tree().paused = false
	if get_tree().reload_current_scene() != OK:
		print("error al reiniciar de escena")
	
func _on_main_menu_pressed():
	get_tree().paused = false
	if get_tree().change_scene("res://ui/main_menu.tscn") != OK:
		print("error al cambiar de escena")
	
