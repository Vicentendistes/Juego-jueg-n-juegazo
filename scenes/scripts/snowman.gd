extends Node2D

onready var particles = $Particles2D
onready var tileset_snow = $TilesetSnow
onready var area = $Area2D
onready var tileset_snow_2 = $TilesetSnow2

func _ready():
	area.connect("body_entered", self, "_on_body_entered")
	

func _on_body_entered(node):
	if node.is_in_group("Player") or node.is_in_group("imantado"):
		tileset_snow.hide()
		tileset_snow_2.show()
		particles.emitting = true
		area.disconnect("body_entered", self, "_on_body_entered")
