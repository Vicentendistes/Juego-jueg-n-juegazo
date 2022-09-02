extends KinematicBody2D

var velocity = Vector2()
var timer = 0
var array = []

var ACCELERATION = 900 
var SPEED = 100
var JUMP_SPEED = 200
var JUMP_TIME = 0.15
var GRAVITY = 10
var FORCE = 500

onready var zone = $Area2D
onready var pivot = $Pivot
onready var anim_tree = $AnimationTree
onready var playback = anim_tree.get("parameters/playback")

func _ready():
	anim_tree.active = true
	zone.connect("body_entered", self, "_on_Area2D_body_entered")
	zone.connect("body_exited", self, "_on_Area2D_body_exited")


func _physics_process(delta):
	velocity = move_and_slide(velocity, Vector2.UP)
	
	var move_input = Input.get_axis("move_left", "move_right")
	velocity.x = move_toward(velocity.x, move_input * SPEED, ACCELERATION*delta) 
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
	if Input.is_action_just_pressed("attract"):
		if array != []:
			var iman = array[0]
			var direction = iman.position - position
			direction = direction / (pow(iman.position.x - position.x, 2) + pow(iman.position.y - position.y, 2))
			velocity += direction.normalized()*FORCE
	

	
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
			
	#==========================================[CAMERA]=========================================




func _on_Area2D_body_entered(body: Node):
	body.rotation = 5
	if not (body in array):
		array.append(body)
	print("ha entrado")
	print(array)
	
func _on_Area2D_body_exited(body: Node):
	body.rotation = 0
	if body in array:
		array.erase(body)
		print("se ha ido")
		print(array)
