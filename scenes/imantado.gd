extends KinematicBody2D


var velocity = Vector2()
var GRAVITY = 10
var FORCE = 23

func _physics_process(_delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.y += GRAVITY
