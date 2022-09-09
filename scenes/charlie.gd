extends KinematicBody2D

# This represents the player's inertia.

var velocity = Vector2()
var timer = 0
var array = []

var ACCELERATION = 900 
var SPEED = 100
var JUMP_SPEED = 200
var JUMP_TIME = 0.15
var GRAVITY = 10

var IMPULSE = 20
var FORCE = 23

onready var zone = $Area2D
onready var pivot = $Pivot
onready var anim_tree = $AnimationTree
onready var playback = anim_tree.get("parameters/playback")

func _ready():
	anim_tree.active = true
	zone.connect("body_entered", self, "_on_Area2D_body_entered")
	zone.connect("body_exited", self, "_on_Area2D_body_exited")


func _physics_process(delta):
	var _is_atracting = false
	#==========================================[VELOCIDAD]=========================================
	velocity = move_and_slide(velocity, Vector2.UP)
	#velocity = move_and_slide(velocity, Vector2.UP, false, 4, PI/4, false)
	
			
			
	var move_input = Input.get_axis("move_left", "move_right")
	velocity.x = move_toward(velocity.x, move_input * SPEED, ACCELERATION*delta)
	if velocity.y < 500:
		velocity.y +=  GRAVITY
	
	if timer > 0:
		timer -= delta/JUMP_TIME
	if Input.is_action_just_pressed("jump"):
		timer = 1
	if is_on_floor() and timer > 0:	
		timer = 0
		velocity.y = -JUMP_SPEED
	
	#back to main menu
	if Input.is_action_pressed("quit"):
	# warning-ignore:return_value_discarded
		if get_tree().change_scene("res://ui/main_menu.tscn") != OK:
			print("error al cambiar de escena")
			
	#=======================================[MAGNETO]===========================================
	if Input.is_action_pressed("attract"):
		if array != []:
			_is_atracting = true
			var iman = array[0]
			var direction = iman.position - position
			direction /= direction.length_squared()
			direction = direction.normalized()*FORCE
			velocity += direction
			iman.velocity -= direction
			
	if Input.is_action_pressed("push"):
		if array != []:
			var iman = array[0]
			var direction = global_position - iman.position
			direction /= direction.length_squared()
			direction = direction.normalized()*FORCE
			velocity += direction
			iman.velocity -= direction
	

	
	#========================================[ANIMATIONS]=======================================
	if Input.is_action_pressed("move_right") and not Input.is_action_pressed("move_left"):
		pivot.scale.x = 1
	if Input.is_action_pressed("move_left") and not Input.is_action_pressed("move_right"):
		pivot.scale.x = -1
	
	if is_on_floor():
		if abs(velocity.x)>10:
			playback.travel("run")
		else:
			playback.travel("idle")
	else:
		if velocity.y < 0:
			playback.travel("jump")
		else:
			playback.travel("fall")
			
	#==========================================[COLISIÓN]=========================================
	# after calling move_and_slide()
	for index in get_slide_count():
		var collision = get_slide_collision(index)
		if collision.collider is Imantado:
			if collision.collider.global_position.y - global_position.y > 14:
				print("arriba")
				collision.collider.push(-collision.normal * velocity.length(), "y")
				
			elif collision.collider.global_position.y - global_position.y < -14:
				print("abajo")
				collision.collider.push(-collision.normal * IMPULSE, "x")
			else:
				print("en medio")
				
				
		#if collision.collider.is_in_group("bodies"):
		#	collision.collider.apply_central_impulse(-collision.normal * IMPULSE) #RigidBody
			
		



#Alcance de la fuerza
func _on_Area2D_body_entered(body: Node):
	var sprite = body.get_node("Icon")
	sprite.self_modulate = Color(1, 1, 1)
	if not (body in array):
		array.append(body)
	
func _on_Area2D_body_exited(body: Node):
	var sprite = body.get_node("Icon")
	sprite.self_modulate = Color(1, 1, 1, 0)
	if body in array:
		array.erase(body)
		
func slide(vector):
	velocity += vector
