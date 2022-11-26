extends MarginContainer

onready var fullscreen = $"%Fullscreen"
onready var back = $"%Back"
onready var music = $"%Music"
onready var sound = $"%Sound"
onready var tiempo = $"%Tiempo"
onready var delete = $"%Delete"

func _ready():
	if OS.window_fullscreen:
		fullscreen.pressed = true
		
	if Global.time_show:
		tiempo.pressed = true
		
	back.connect("pressed", self, "_on_back_pressed")
	fullscreen.connect("toggled", self, "_on_fullscreen_toggled")
	fullscreen.grab_focus()
	tiempo.connect("toggled", self, "_on_tiempo_toggled")
	music.connect("value_changed", self, "_on_Music_value_changed")
	music.value = MusicController.volume
	
	
func _on_back_pressed():
	if get_tree().change_scene("res://ui/main_menu.tscn") != OK:
		print("error al cambiar de escena")


func _on_fullscreen_toggled(button_pressed):
	OS.set_window_fullscreen(button_pressed)

func _on_tiempo_toggled(button_pressed):
	Global.time_show = button_pressed
	
func _on_Music_value_changed(value):
	MusicController.volume = value
	MusicController.update()
	
