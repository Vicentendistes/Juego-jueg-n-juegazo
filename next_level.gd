extends Sprite


# Called when the node enters the scene tree for the first time.
func _ready():
	var hitbox = $Area2D
	hitbox.connect("body_exited", hitbox, "_on_hitbox_body_entered")
	
	
func _on_hitbox_body_entered(body: Node):
		
	
