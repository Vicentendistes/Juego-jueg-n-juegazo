extends MarginContainer

onready var play = get_node("%Play")
onready var credits = get_node("%Credits")
onready var exit = get_node("%Exit")
onready var settings = get_node("%Settings")


func _ready():
	if not MusicController.playing_menu:
		MusicController.play_menu_music()
	play.connect("pressed", self, "_on_play_pressed")
	settings.connect("pressed", self, "_on_settings_pressed")
	credits.connect("pressed", self, "_on_credits_pressed")
	exit.connect("pressed", self, "_on_exit_pressed")
	play.grab_focus()
	
func _on_play_pressed():
	if get_tree().change_scene("res://ui/levels.tscn") != OK:
		print("error al cambiar de escena")
	
func _on_settings_pressed():
	if get_tree().change_scene("res://ui/settings.tscn") != OK:
		print("error al cambiar de escena")
	
func _on_credits_pressed():
	print("faltan los creditos")
	#if get_tree().change_scene() != OK:
	#	print("error al cambiar de escena")
	
func _on_exit_pressed():
	get_tree().quit()
