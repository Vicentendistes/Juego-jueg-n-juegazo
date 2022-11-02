extends MarginContainer


onready var back = get_node("%Back")
onready var buttons = $VBoxContainer/GridContainer
onready var levels = []



func _ready():
	Global.respawn = null #restart respawn
	if MusicController.playing != "Menu":
		MusicController.play_menu_music()
	back.connect("pressed", self, "_on_back_pressed")
	
	#checks levels folder and add path to levels list
	var dir = Directory.new()
	dir.open("res://scenes/levels/")
	dir.list_dir_begin()
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			levels.append("res://scenes/levels/"+str(file))
	dir.list_dir_end()

	#add a signal wich connects a button to a level
	for i in range(len(levels)):
		var level = get_node("%Button"+str(i+1))
		level.connect("pressed", self, "_on_level_pressed", [i])
		
	#disabled unused buttons
	var count = 1	
	for button in buttons.get_children():
		if count > len(levels):
			button.disabled = true
		count +=1
		
	#focus level 1
	var level1 =  get_node("%Button1")
	level1.grab_focus()
	

func _on_back_pressed():
	if get_tree().change_scene("res://ui/main_menu.tscn") != OK:
		print("error al cambiar de escena")

func _on_level_pressed(i):
	SceneTransition.change_scene(levels[i])
