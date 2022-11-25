extends MarginContainer


onready var back = get_node("%Back")
onready var buttons = $VBoxContainer/GridContainer
onready var levels = []



func _ready():
	Global.time_on = false #rets
	Global.respawn = null #restart respawn
	MusicController.play_menu_music()
	back.connect("pressed", self, "_on_back_pressed")
	
	levels = Data.levels #save levels with global levels

	#add a signal wich connects a button to a level
	for i in range(len(levels)):
		var button = Button.new()
		button.text = str(i)
		button.set_h_size_flags(3)
		buttons.add_child(button)
		button.connect("pressed", self, "_on_level_pressed", [i])
		if i == 0:
			button.grab_focus()
		elif i > Data.max_level:
			button.disabled = true

func _on_back_pressed():
	if get_tree().change_scene("res://ui/main_menu.tscn") != OK:
		print("error al cambiar de escena")

func _on_level_pressed(i):
	Data.set_current_level(i) #saves current level in global
	SceneTransition.change_scene(levels[i])
