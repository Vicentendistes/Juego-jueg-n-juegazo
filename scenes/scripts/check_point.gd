extends Area2D


func _ready():
# warning-ignore:return_value_discarded
	self.connect("body_entered", self, "_on_body_entered")
	
func _on_body_entered(body):
	if body.is_in_group("Player"):
		Global.respawn = self.global_position
