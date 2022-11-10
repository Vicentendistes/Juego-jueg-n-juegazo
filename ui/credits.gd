extends MarginContainer

onready var credits_container = $ScrollContainer/CreditsContainer

var credits = [
	{
	"name": "Glacial Mountains: Parallax Background",
	"autor": "vnitti.itch.io"
	},
	{
	"name": "Hooded Figure Character Pack",
	"autor": "fartfish.itch.io"
	},
	{
	"name": "Rocky Roads Asset Pack",
	"autor": "essssam.itch.io"
	},
	{
	"name": "Background Desert Mountains",
	"autor": "szadiart.itch.io"
	},
	{
	"name": "Forest Lite Pixel Art Tileset",
	"autor": "sanctumpixel.itch.io"
	},
	{
	"name": "Forest Tileset",
	"autor": "mamanezakon.itch.io"
	}
]

func _ready():
	MusicController.play_credits_music()
	$ScrollContainer.get_v_scrollbar().rect_scale.x = 0
	for credit in credits:
		var h_separator = HSeparator.new()
		h_separator.theme_type_variation = "SmallSeparator"
		var name_label = _create_label(credit.name)
		var autor_label = _create_label(credit.autor)
		credits_container.add_child(name_label)
		credits_container.add_child(autor_label)
		credits_container.add_child(h_separator)
		
		
func _input(event):
	if event.is_action_pressed("quit"):
		SceneTransition.change_scene("res://ui/main_menu.tscn")
		
func _create_label(text) -> Label:
	var label = Label.new()
	label.text = text
	label.align = Label.ALIGN_CENTER
	label.autowrap = true
	return label

