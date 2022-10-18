extends MarginContainer

onready var fullscreen = $"%Fullscreen"
onready var back = $"%Back"

func _ready():
	if OS.window_fullscreen:
		fullscreen.pressed = true
		
	back.connect("pressed", self, "_on_back_pressed")
	fullscreen.connect("toggled", self, "_on_fullscreen_toggled")
	back.grab_focus()
	
func _on_back_pressed():
	if get_tree().change_scene("res://ui/main_menu.tscn") != OK:
		print("error al cambiar de escena")
	
	
func _on_fullscreen_toggled(button_pressed):
	OS.set_window_fullscreen(button_pressed)

