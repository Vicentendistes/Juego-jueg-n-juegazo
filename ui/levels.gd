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
	
	var times = $"%Times"
	var text_times = ""
	var level = 0
	for time in Data.time_levels:
		var mils = fmod(time,1)*1000
		var secs = fmod(time,60)
		var mins = fmod(time, 60*60) / 60
		var time_passed = "%02d : %02d: %03d" % [mins,secs,mils]
		text_times += "level "+str(level) + " ("+str(time_passed)+") \n"
		level +=1
	times.text = text_times
	
func _on_back_pressed():
	if get_tree().change_scene("res://ui/main_menu.tscn") != OK:
		print("error al cambiar de escena")

func _on_level_pressed(i):
	Data.current_level = i #saves current level in global
	SceneTransition.change_scene(levels[i])
