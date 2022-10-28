extends Node

#load the music
var menu_music = load("res://assets/Intro2.0.wav")
var snow_music = load("res://assets/Radiatta.wav")
var dirt_music = load("res://assets/PitcherPerfectTheme.wav")
#know the state before going back or change scene
var playing_menu = false
var playing_snow = false
var playing_dirt = false

func _ready():
	pass

#functions to play the music
func play_menu_music():
	$Music.stream = menu_music
	$Music.play()
	playing_menu = true
	playing_snow = false
	playing_dirt = false
	
func play_snow_music():
	$Music.stream = snow_music
	$Music.play()
	playing_menu = false
	playing_snow = true
	playing_dirt = false
	
func play_dirt_music():
	$Music.stream = dirt_music
	$Music.play()
	playing_menu = false
	playing_snow = false
	playing_dirt = true
