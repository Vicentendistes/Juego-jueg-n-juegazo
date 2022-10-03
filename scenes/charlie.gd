extends KinematicBody2D

var velocity = Vector2()
var timer = 0
var array = []

var ACCELERATION = 900 
var SPEED = 100
var JUMP_SPEED = 200
var JUMP_TIME = 0.15
var GRAVITY = 10

var IMPULSE = 20
var FORCE = 20

onready var zone = $Area2D
onready var pivot = $Pivot
onready var anim_tree = $AnimationTree
onready var playback = anim_tree.get("parameters/playback")

func _ready():
	anim_tree.active = true
	zone.connect("body_entered", self, "_on_Area2D_body_entered")
	zone.connect("body_exited", self, "_on_Area2D_body_exited")


func _physics_process(delta):
	#==================================[BASIC CONTROLS]=========================================
	velocity = move_and_slide(velocity, Vector2.UP)
	#velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI/4, false)
	
	#right and left movements
	var move_input = Input.get_axis("move_left", "move_right")
	velocity.x = move_toward(velocity.x, move_input * SPEED, ACCELERATION*delta)
	if velocity.y < 500:
		velocity.y +=  GRAVITY
	
	#jump
	if timer > 0:
		timer -= delta/JUMP_TIME
	if Input.is_action_just_pressed("jump"):
		timer = 1
	if is_on_floor() and timer > 0:	
		timer = 0
		velocity.y = -JUMP_SPEED
			
	#=======================================[MAGNETO]===========================================
	var iman = null
	var direction = Vector2()
	var minimo = 10000000
	var numero = 0 
	if array != []:
		
		for i in range(len(array)):
			var a = global_position
			var b = array[i].global_position
			var hola = array[i].get_node("Icon")
			hola.self_modulate = Color(1,1,1,0)
			if (a-b).length() < minimo:
				minimo = (a-b).length()
				numero = i
		iman = array[numero]
		var icon = iman.get_node("Icon")
		icon.self_modulate = Color(1, 1, 1, 1)
	
	if Input.is_action_pressed("attract"):
		if iman != null:
			direction = global_position - iman.position
			direction /= direction.length_squared()
			direction = direction.normalized()*FORCE
			velocity -= direction
			iman.velocity += direction
			
		
	if Input.is_action_pressed("push"):
		if iman != null:
			direction = global_position - iman.position
			direction /= direction.length_squared()
			direction = direction.normalized()*FORCE
			velocity += direction
			iman.velocity -= direction
	
	#==========================================[COLLISION]=========================================
	#colitions with Imantado after calling move_and_slide()
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider is Imantado:
			var difference = collision.collider.global_position.y - global_position.y
			
			if  difference > 7 + collision.collider.height and collision.collider.velocity.y < 400:
				#print("arriba")
				collision.collider.push(-collision.normal * velocity.length(), "y")
				
			elif difference < -(7 + collision.collider.height):
				#print("abajo")
				#collision.collider.push(-collision.normal * IMPULSE, "x")
				pass
			else:
				#print("en medio")
				#collision.collider.push(-collision.normal * IMPULSE, "x")
				pass
		#if collision.collider.is_in_group("bodies"):
		#	collision.collider.apply_central_impulse(-collision.normal * IMPULSE) #RigidBody

	
	#========================================[ANIMATIONS]=======================================
	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		pivot.scale.x = 1
	if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		pivot.scale.x = -1
	
	if is_on_floor():
		if abs(velocity.x)>25:
			playback.travel("run")
		else:
			playback.travel("idle")
	else:
		if velocity.y < 0:
			playback.travel("jump")
		else:
			playback.travel("fall")


#Alcance de la fuerza
func _on_Area2D_body_entered(body: Node):
	array.append(body)
	
func _on_Area2D_body_exited(body: Node):
	var icon = body.get_node("Icon")
	icon.self_modulate = Color(1, 1, 1, 0)
	array.erase(body)

func push(vector, t):
	if t=="x":
		velocity.x += vector.x
	if t=="y":
		velocity.y += vector.y
	if t=="xy":
		velocity += vector
