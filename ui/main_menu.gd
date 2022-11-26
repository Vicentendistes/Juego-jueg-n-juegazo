extends MarginContainer

onready var play = get_node("%Play")
onready var credits = get_node("%Credits")
onready var exit = get_node("%Exit")
onready var settings = get_node("%Settings")
onready var delete = $"%Delete"


func _ready():
	if MusicController.playing != "Menu":
		MusicController.play_menu_music()
	play.connect("pressed", self, "_on_play_pressed")
	settings.connect("pressed", self, "_on_settings_pressed")
	credits.connect("pressed", self, "_on_credits_pressed")
	exit.connect("pressed", self, "_on_exit_pressed")
	play.grab_focus()
	
	delete.connect("pressed", self, "_on_delete_pressed")

	
func _on_play_pressed():
	if get_tree().change_scene("res://ui/levels.tscn") != OK:
		print("error al cambiar de escena")
	
func _on_settings_pressed():
	if get_tree().change_scene("res://ui/settings.tscn") != OK:
		print("error al cambiar de escena")
	
func _on_credits_pressed():
	SceneTransition.change_scene("res://ui/credits.tscn")
	
func _on_exit_pressed():
	Data.save_data()
	get_tree().quit()
	
func _on_delete_pressed():
	Data.clean_data()
