extends MarginContainer

onready var resume = $"%Resume"
onready var restart = $"%Restart"
onready var settings = $"%Settings"
onready var main_menu = $"%MainMenu"
onready var v_box_container_2 = $VBoxContainer2
onready var v_box_container = $VBoxContainer
onready var fullscreen = $"%Fullscreen"
onready var back = $"%Back"

func _ready():
	resume.connect("pressed", self, "_on_resume_pressed")
	restart.connect("pressed", self, "_on_restart_pressed")
	main_menu.connect("pressed", self, "_on_main_menu_pressed")
	
	if OS.window_fullscreen:
		fullscreen.pressed = true
	settings.connect("pressed", self, "_on_settings_pressed")
	fullscreen.connect("toggled", self, "_on_fullscreen_toggled")
	back.connect("pressed", self, "_on_back_pressed")
	hide()
	
func _input(event):
	if event.is_action_pressed("restart"):
		get_tree().paused = false
		if get_tree().reload_current_scene() != OK:
			print("error al reiniciar de escena")
		
		
	if event.is_action_pressed("quit"):
		visible = !visible
		get_tree().paused = visible
		v_box_container_2.visible = false
		v_box_container.visible = true
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

func _on_settings_pressed():
	v_box_container.visible = false
	v_box_container_2.visible = true
	fullscreen.grab_focus()

func _on_fullscreen_toggled(button_pressed):
	OS.set_window_fullscreen(button_pressed)
	
	
func _on_back_pressed():
	v_box_container_2.visible = false
	v_box_container.visible = true
	resume.grab_focus()
