extends CharacterBody3D


const SPEED = 5.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta
		
	# Handle rotation
	if Input.is_action_just_pressed("rotate_cw"):
		self.rotate(Vector3(0, 1, 0), 0.5 * PI)
		
	if Input.is_action_just_pressed("rotate_ccw"):
		self.rotate(Vector3(0, 1, 0), -0.5 * PI)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	if velocity.x > 0:
		$Sprite3D.flip_h = true
	elif velocity.x < 0:
		$Sprite3D.flip_h = false
	
	move_and_slide()