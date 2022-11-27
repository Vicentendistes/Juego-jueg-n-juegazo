extends Node

var levels = []
var current_level = 0
var max_level = 0
var time_levels = []

var path = "user://db.json"
var db = {}

func _ready():
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
			time_levels.append(0)
	dir.list_dir_end()
	
	load_data()#load data file
	
func load_data():
	var file = File.new()
	if not file.file_exists(path):
		return
	file.open(path, File.READ)
	var content = file.get_as_text()
	file.close()
	db = JSON.parse(content).result
	max_level = db.max_level
	for i in range(len(time_levels)):
		if i < len(db.time_levels):
			time_levels[i] = db.time_levels[i]

func save_data():
	var file = File.new()
	file.open(path, File.WRITE)
	var save_data = {"max_level":max_level, "time_levels":time_levels}
	file.store_line(to_json(save_data))

func clean_data():
	max_level = 0
	time_levels = []
	for _i in range(len(levels)):
		time_levels.append(0)

func set_max_level(value)->void:
	if value > max_level:
		max_level = value
		
func set_max_time(value)->void:
	if value < time_levels[current_level] or time_levels[current_level]==0:
		time_levels[current_level] = value
	
