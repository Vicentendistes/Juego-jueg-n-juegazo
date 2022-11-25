extends Node

var levels = []
var current_level = 0
var max_level = 0

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
	dir.list_dir_end()
	
	load_data()#load data file
	
func load_data():
	var file = File.new()
	if not file.file_exists("res://data/db.json"):
		print("No existe el archivo")
	file.open("res://data/db.json", File.READ)
	var content = file.get_as_text()
	file.close()
	self.db = JSON.parse(content).result
	max_level = db.max_level

func save_data():
	var file = File.new()
	file.open("res://data/db.json", File.WRITE)
	if max_level != null:
		db.max_level = max_level
	file.store_line(to_json(db))
	
func set_current_level(value)->void:
	Data.current_level = value
	if current_level>max_level:
		max_level = current_level
	
