extends KinematicBody2D

class_name Imantado

var velocity = Vector2()
var GRAVITY = 10
var ACCELERATION = 200

func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = move_toward(velocity.x, 0, ACCELERATION*delta)
	velocity.y += GRAVITY

	
func slide(vector):
	velocity.x = vector.x
