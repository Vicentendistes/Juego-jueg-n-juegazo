extends CanvasLayer

func change_scene(target: String) -> void:
	var scene = get_tree()
	$AnimationPlayer.play("dissolve")
	yield($AnimationPlayer, "animation_finished")
	if not scene.change_scene(target):
		print("Error al cambiar de escena:"+target)
	$AnimationPlayer.play_backwards("dissolve")
