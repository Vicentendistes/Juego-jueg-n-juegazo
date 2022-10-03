extends Sprite

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	material.set_shader_param("aura_width", 0)
 # Replace with function body.

func aura(s):
	material.set_shader_param("aura_width", s)
