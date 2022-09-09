extends MarginContainer

onready var resume = $"%Resume"
onready var settings = $"%Settings"
onready var main_menu = $"%MainMenu"

func _ready():
	resume.connect("pressed", self, "_on_resume_pressed")
	settings.connect("pressed", self, "_on_settings_pressed")
	main_menu.connect("pressed", self, "_on_main_menu_pressed")
	
func _on_resume_pressed():
	pass
	
func _on_settings_pressed():
	pass
	
func _on_main_menu_pressed():
	pass
	
