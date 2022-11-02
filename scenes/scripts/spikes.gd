extends StaticBody2D

func _ready():
	var area = $Area2D
	var state = area.connect("body_entered", self, "_on_area_body_entered")
	if state:
		print("error al conectar")

	
func _on_area_body_entered(body: Node):
	if body.is_in_group("Player"):
		body.died()
	
