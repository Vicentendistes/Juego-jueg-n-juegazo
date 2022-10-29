extends Node2D

onready var particles = $Particles2D
onready var tileset_snow = $TilesetSnow
onready var area = $Area2D

func _ready():
	area.connect("body_entered", self, "_on_body_entered")
	

func _on_body_entered(node):
	if node.is_in_group("Player"):
		tileset_snow.hide()
		particles.emitting = true
