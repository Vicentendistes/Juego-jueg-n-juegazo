extends KinematicBody2D

class_name Imantado

onready var collision_shape_2d = $CollisionShape2D
onready var respawn = global_position
onready var dust = $Pivot/Dust
onready var pivot = $Pivot


onready var shape_dimentions = collision_shape_2d.shape.get_extents()
onready var width = shape_dimentions.x * self.scale.x
onready var height = shape_dimentions.y * self.scale.y
onready var ACCELERATION = 300*self.scale.x * self.scale.y + 200
onready var interact = false

var velocity = Vector2()
var IMPULSE = 40
var GRAVITY = 10


func _physics_process(delta):
	#move and slide
	velocity = move_and_slide(velocity, Vector2.UP)
	
	#more drag when not interacting or when is on floor
	if not interact:
		velocity.x = move_toward(velocity.x, 0, ACCELERATION*delta)
	else:
		if is_on_floor():
			velocity.x = move_toward(velocity.x, 0, ACCELERATION*delta)
		else:
			velocity.x = move_toward(velocity.x, 0, ACCELERATION*0.5*delta)
	
	#dust particles emitting conditions
	if is_on_floor() and abs(velocity.x)>50:
		if velocity.x>0:
			pivot.scale.x = 1
		else:
			pivot.scale.x = -1
		dust.emitting = true
	else:
		dust.emitting = false 
			
	#solve multiples player hits from above
	if velocity.y < 500:
		velocity.y +=  GRAVITY
		
	#collitions
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider.is_in_group("Player"):
			var difference = global_position - collision.collider.global_position
			#print(difference)
			if difference.y < -7:
				#print("choque")
				collision.collider.push(-difference.normalized() * IMPULSE, "x")
				push(difference.normalized() * (IMPULSE+20), "x")
				
		if collision.collider.is_in_group("imantado"):
			var difference = global_position - collision.collider.global_position
			collision.collider.push(-difference.normalized() * IMPULSE, "x")
	
#auxiliar function collitions
func push(vector, t):
	if t=="x":
		velocity.x += vector.x
	if t=="y":
		velocity.y += vector.y
	if t=="xy":
		velocity += vector
		

	
