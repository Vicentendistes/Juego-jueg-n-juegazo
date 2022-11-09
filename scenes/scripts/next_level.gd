extends Sprite

onready var levels = []
onready var current_level_index

func _ready():
	$AnimationPlayer.play("ciclo")
	var hitbox = $Area2D
	#add signal to enter next level
	hitbox.connect("body_entered", self, "_on_hitbox_body_entered")
	
	
func _on_hitbox_body_entered(body):
	MusicController.play_complete_music()
	if body.is_in_group("Player"):
		body.dead = true
		body.next_level()
