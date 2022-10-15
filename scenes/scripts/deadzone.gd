extends Area2D



func _ready():
	connect("body_entered", self, "_on_DeadZone_body_entered")
	

func _on_DeadZone_body_entered(body: Node):
	body.global_position = Vector2(264, 24)
