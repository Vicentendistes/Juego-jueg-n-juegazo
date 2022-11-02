extends Area2D

func _ready():
	var state = connect("body_entered", self, "_on_DeadZone_body_entered")
	if state:
		print("error al conectar")
	
func _on_DeadZone_body_entered(body: Node):
	if body.is_in_group("Player"):
		body.dead = true
		SceneTransition.reload_current_scene()
	elif body.is_in_group("imantado"):
		body.global_position = body.respawn
