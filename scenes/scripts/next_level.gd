extends Sprite

onready var levels = []
onready var current_level_index

func _ready():
	$AnimationPlayer.play("ciclo")
	var hitbox = $Area2D
	#checks levels folder and add path to levels list
	var dir = Directory.new()
	dir.open("res://scenes/levels/")
	dir.list_dir_begin()
	var i = 0
	while true:
		var file = dir.get_next()
		if file == "":
			break
		elif not file.begins_with("."):
			levels.append("res://scenes/levels/"+str(file))
			#save current scene index
			if "res://scenes/levels/"+str(file) == get_tree().current_scene.filename:
				current_level_index = i
			i += 1
	dir.list_dir_end()
	
	#add signal to enter next level
	hitbox.connect("body_entered", self, "_on_hitbox_body_entered")
	
	
func _on_hitbox_body_entered(body):
	if body.is_in_group("Player"):
		body.dead = true
		body.next_level()
	#if i< len(levels):
	#	SceneTransition.change_scene(levels[i])

	#else:
	#	SceneTransition.change_scene("res://ui/levels.tscn")
		
	
