extends Sprite

func _ready():
	$AnimationPlayer.play("ciclo")
	var hitbox = $Area2D
	#add signal to enter next level
	hitbox.connect("body_entered", self, "_on_hitbox_body_entered")
	
	
func _on_hitbox_body_entered(body):
	if body.is_in_group("Player"):
		MusicController.play_complete_music()
		body.dead()
		body.next_level()
