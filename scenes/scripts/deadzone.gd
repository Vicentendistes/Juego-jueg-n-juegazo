extends Area2D

onready var respawn = get_node("Position2D")

func _ready():
	var state = connect("body_entered", self, "_on_DeadZone_body_entered")
	if state:
		print("error al conectar")
	
func _on_DeadZone_body_entered(body: Node):
	body.global_position = respawn.position
