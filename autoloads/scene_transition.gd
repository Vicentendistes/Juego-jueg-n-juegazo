extends CanvasLayer

func change_scene(target: String) -> void:
	var scene = get_tree()
	$AnimationPlayer.play("dissolve")
	yield($AnimationPlayer, "animation_finished")
	if not scene.change_scene(target):
		pass
	$AnimationPlayer.play_backwards("dissolve")

func reload_current_scene() -> void:
	$AnimationPlayer.play("dissolve")
	yield($AnimationPlayer, "animation_finished")
	if get_tree().reload_current_scene() != OK:
			pass
	$AnimationPlayer.play_backwards("dissolve")
	yield($AnimationPlayer, "animation_finished")
	
