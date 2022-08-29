extends MarginContainer

onready var play = $VBoxContainer/Play
onready var credits = $VBoxContainer/Credits
onready var exit = $VBoxContainer/Exit
onready var settings = $VBoxContainer/Settings


func _ready():
	play.connect("pressed", self, "_on_play_pressed")
	settings.connect("pressed", self, "_on_settings_pressed")
	credits.connect("pressed", self, "_on_credits_pressed")
	exit.connect("pressed", self, "_on_exit_pressed")
	
func _on_play_pressed():
	get_tree().change_scene("res://scenes/Main.tscn")
	
func _on_settings_pressed():
	get_tree().change_scene("res://ui/settings.tscn")
	
func _on_credits_pressed():
	get_tree().change_scene("res://scenes/level_01.tscn")
	
func _on_exit_pressed():
	get_tree().quit()
