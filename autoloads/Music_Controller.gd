extends Node

#load the music
var menu_music = load("res://assets/Intro2.0.wav")
var snow_music = load("res://assets/Radiatta.wav")
var dirt_music = load("res://assets/PitcherPerfectTheme.wav")
#know the state before going back or change scene
var playing

func _ready():
	pass
	
func play_music(node):
	$Music.volume_db = 0
	var level_type = node.get_parent().name
	#play music if is in the special scene or is not already playing
	if level_type == "Snow":
		play_snow_music()
	if level_type == "Dirt":
		play_dirt_music()

#functions to play the music
func play_menu_music():
	$Music.volume_db = -5
	$Music.stream = menu_music
	$Music.play()
	playing = "Menu"
	
func play_snow_music():
	if playing != "Snow":
		$Music.stream = snow_music
		$Music.play()
		playing = "Snow"
	
func play_dirt_music():
	$Music.volume_db = -15
	if playing != "Dirt":
		$Music.stream = dirt_music
		$Music.play()
		playing = "Dirt"
