extends Area2D
onready var fire = $Fire
onready var animation_tree = $AnimationTree
onready var playback = animation_tree.get("parameters/playback")
onready var animation_player = $AnimationPlayer


func _ready():
# warning-ignore:return_value_discarded
	self.connect("body_entered", self, "_on_body_entered")
	animation_tree.active = true
	
	
func _on_body_entered(body):
	if body.is_in_group("Player"):
		if Global.active_respawn != fire:
			if Global.respawn != self.global_position:
				playback.travel("start")
				yield(get_tree().create_timer(0.5),"timeout")
			#yield(animation_player, "animation_started")
			fire.set_modulate(Color("#79fdf7"))
			if Global.active_respawn != null and is_instance_valid(Global.active_respawn):
				Global.active_respawn.set_modulate(Color(1, 1, 1, 1))
		Global.active_respawn = fire
		Global.respawn = self.global_position
