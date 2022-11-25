extends Node

#load the music
var menu_music = load("res://assets/Intro.wav")
var snow_music = load("res://assets/Radiatta.wav")
var dirt_music = load("res://assets/PitcherPerfectTheme.wav")
var desert_music = load("res://assets/8bit.wav")
var complete_music = load("res://assets/Finalmente.wav")
var credits_music = load("res://assets/Guaracha Austral.wav")
#know the state before going back or change scene
var playing
#controll the volume
var volume = 0
var song_volume = 0

func update():
	$Music.volume_db = volume + song_volume
	
func play_music(node):
	var level_type = node.get_parent().name
	#play music if is in the special scene or is not already playing
	if level_type == "Snow":
		play_snow_music()
	if level_type == "Dirt":
		play_dirt_music()
	if level_type == "Desert":
		play_desert_music()

#functions to play the music
func play_menu_music():
	song_volume = -16
	if MusicController.playing != "Menu":
		$Music.stream = menu_music
		update()
		$Music.play()
		playing = "Menu"
	
func play_snow_music():
	song_volume = -12
	if playing != "Snow":
		$Music.stream = snow_music
		update()
		$Music.play()
		playing = "Snow"
	
func play_dirt_music():
	song_volume = -30
	if playing != "Dirt":
		$Music.stream = dirt_music
		update()
		$Music.play()
		playing = "Dirt"

func play_desert_music():
	song_volume = -20
	if playing != "Desert":
		$Music.stream = desert_music
		update()
		$Music.play()
		playing = "Desert"
		
func play_complete_music():
	playing = "Complete"
	song_volume = -16
	$Music.stream = complete_music
	update()
	$Music.play()
	
func play_credits_music():
	playing = "Credits"
	song_volume = -10
	$Music.stream = credits_music
	update()
	$Music.play()
