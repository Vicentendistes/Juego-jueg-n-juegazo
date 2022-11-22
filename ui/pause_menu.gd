extends MarginContainer

onready var v_box_container = $VBoxContainer
onready var resume = $"%Resume"
onready var restart = $"%Restart"
onready var settings = $"%Settings"
onready var main_menu = $"%MainMenu"

onready var v_box_container_2 = $VBoxContainer2
onready var fullscreen = $"%Fullscreen"
onready var tiempo = $"%Tiempo"
onready var music = $"%Music"
onready var sound = $"%Sound"
onready var back = $"%Back"

onready var v_box_container_3 = $VBoxContainer3
onready var next = $VBoxContainer3/Next
onready var restart2 = $VBoxContainer3/Restart
onready var main_menu2 = $VBoxContainer3/MainMenu

func _ready():
	#Pause
	resume.connect("pressed", self, "_on_resume_pressed")
	restart.connect("pressed", self, "_on_restart_pressed")
	main_menu.connect("pressed", self, "_on_main_menu_pressed")
	
	#Completed
	restart2.connect("pressed", self, "_on_restart_pressed")
	main_menu2.connect("pressed", self, "_on_main_menu_pressed")
	next.connect("pressed", self, "_on_next_pressed")
	
	#Settings
	if OS.window_fullscreen:
		fullscreen.pressed = true
	if Global.time_show:
		tiempo.pressed = true
	settings.connect("pressed", self, "_on_settings_pressed")
	fullscreen.connect("toggled", self, "_on_fullscreen_toggled")
	tiempo.connect("toggled", self, "_on_tiempo_toggled")
	back.connect("pressed", self, "_on_back_pressed")
	music.connect("value_changed", self, "_on_Music_value_changed")
	music.value = MusicController.volume
	hide()
	


#==============================[INPUTS]==================================
func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().paused = false
		hide()
		get_owner().restart() #restart charlie
		
	if event.is_action_pressed("quit"):
		visible = !visible
		get_tree().paused = visible
		v_box_container_2.visible = false
		v_box_container.visible = true
		resume.grab_focus()

#==============================[PAUSE SIGNALS]==================================
func _on_resume_pressed():
	get_tree().paused = false
	hide()
	
func _on_restart_pressed():
	Global.time_on = false #restart time
	Global.respawn = null #restart respawn point
	get_tree().paused = false
	hide()
	get_owner().restart()
	
func _on_main_menu_pressed():
	get_tree().paused = false
	SceneTransition.change_scene("res://ui/main_menu.tscn")

func _on_settings_pressed():
	v_box_container.visible = false
	v_box_container_2.visible = true
	fullscreen.grab_focus()

#==============================[SETTINGS SIGNALS]==================================
func _on_fullscreen_toggled(button_pressed):
	OS.set_window_fullscreen(button_pressed)
	
func _on_tiempo_toggled(button_pressed):
	Global.time_show = button_pressed
	print(Global.time_show)
	
func _on_back_pressed():
	v_box_container_2.visible = false
	v_box_container.visible = true
	resume.grab_focus()
	
func _on_Music_value_changed(value):
	print(value)
	MusicController.volume = value

#==============================[COMPLETED SIGNALS]==================================
func completed()->void:
	self.set_process_input(false)
	Global.time_on = false
	var time = Global.time
	var mils = fmod(time,1)*1000
	var secs = fmod(time,60)
	var mins = fmod(time, 60*60) / 60
	
	var time_passed = "Tu tiempo fue de: %02d : %02d . %03d" % [mins,secs, mils]
	$VBoxContainer3/Score.text = time_passed
	visible = !visible
	#get_tree().paused = visible
	v_box_container_2.visible = false
	v_box_container.visible = false
	v_box_container_3.visible = true
	next.grab_focus()
	
func _on_next_pressed():
	get_tree().paused = false
	Global.current_level += 1
	#Change next level
	if (Global.current_level)< len(Global.levels):
		SceneTransition.change_scene(Global.levels[Global.current_level])
	else:
		SceneTransition.change_scene("res://ui/credits.tscn")
