extends CharacterBody3D

const SPEED = 5.0
const JUMP_VELOCITY = 4.0
const FRAMES = 4

@export var animation_frame = 0
@onready var facing = 0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
	
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY
	
	if Input.is_action_pressed("rotate_left"):
		#$CameraPivot.rotation_degrees.y -= 1
		self.rotation_degrees.y -= 1

	if Input.is_action_pressed("rotate_right"):
		#$CameraPivot.rotation_degrees.y += 1
		self.rotation_degrees.y += 1

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_up", "move_down")
	var direction = (self.transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	walk_animation(direction)
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event):
	if Input.is_action_pressed("zoom_in"):
		if $PlayerCamera.size > 10:
			$PlayerCamera.size -= 1
	if Input.is_action_pressed("zoom_out"):
		if $PlayerCamera.size < 12:
			$PlayerCamera.size += 1

func walk_animation(direction):
	if direction == Vector3(0,0,0):
		$PlayerAnimation.stop()
		animation_frame = 0
	else:
		$PlayerAnimation.play("walk")
		
	if Input.is_action_pressed("move_down"): 
		facing = 0
	elif Input.is_action_pressed("move_up"):
		facing = 2
	elif Input.is_action_pressed("move_left"):
		$PlayerSprite.flip_h = true
		facing = 1
	elif Input.is_action_pressed("move_right"):
		$PlayerSprite.flip_h = false
		facing = 1

	$PlayerSprite.frame = animation_frame + (facing * FRAMES)
