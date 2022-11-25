extends MarginContainer

onready var credits_container = $ScrollContainer/CreditsContainer
onready var scroll_container = $ScrollContainer
var scroll_speed = 1
var scroll_ended = false
var scroll_pause = false

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
	},
	{
	"name": "Fire Animation - Pixel Art FX Sprites  ",
	"autor": "brullov.itch.io"
	},
	{
	"name": "Not Jam Music Pack",
	"autor": "not-jam.itch.io"
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
	var press_exit = _create_label("\n \n \n \n \n \n \n \n \n \n \n \n \n \n Presione Esc para volver al menú \n")
	credits_container.add_child(press_exit)
	
	#Copy from tutorial
	set_physics_process(false)
	yield(get_tree().create_timer(1), "timeout")
	set_physics_process(true)
	
func _physics_process(_delta):
	var last_scroll = scroll_container.scroll_vertical
	scroll_container.scroll_vertical += scroll_speed
	var new_scroll = scroll_container.scroll_vertical
	if last_scroll == new_scroll:
		set_physics_process(false)
		#_to_main_menu()
		
		
func _input(event):
	if event.is_action_pressed("quit"):
		SceneTransition.change_scene("res://ui/main_menu.tscn")
		
func _create_label(text) -> Label:
	var label = Label.new()
	label.text = text
	label.align = Label.ALIGN_CENTER
	label.autowrap = true
	return label
	
func _to_main_menu():
	if not scroll_ended:
		scroll_ended = true
		yield(get_tree().create_timer(2), "timeout")
		SceneTransition.change_scene("res://ui/main_menu.tscn")

