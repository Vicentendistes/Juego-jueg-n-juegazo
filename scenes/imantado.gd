extends KinematicBody2D

class_name Imantado

var IMPULSE = 40
var velocity = Vector2()
var GRAVITY = 10
var ACCELERATION = 500

func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	#velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI/4, false)
	velocity.x = move_toward(velocity.x, 0, ACCELERATION*delta)
	velocity.y += GRAVITY
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("Player"):
			var difference = global_position - collision.collider.global_position
			#print(difference)
			if difference.y < -14:
				#print("choque")
				collision.collider.push(-difference.normalized() * IMPULSE, "x")
				push(difference.normalized() * IMPULSE, "x")
	
	
func push(vector, t):
	if t=="x":
		velocity.x += vector.x
	if t=="y":
		velocity.y += vector.y
	if t=="xy":
		velocity += vector
		
	
