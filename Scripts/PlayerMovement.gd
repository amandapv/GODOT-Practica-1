extends CharacterBody3D


const SPEED = 1
const SPEED_2 = 7.0
const JUMP_VELOCITY = 4.5

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y -= gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir = Input.get_vector("left", "right", "up", "down") #le cambié la dirección de las flechas para que el movimiento se haga con AWSD
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var input_dir_2 = Input.get_vector("ui_left", "shiftRight", "shiftUp", "shiftDown") #!! no me deja mapear otra vez AWSD con shift así que probé shiftRight con la letra M + shift, y funciona. Puse ui_left con la flecha izquierda para verficar que me deja moverme con dicha tecla
	var direction_2 = (transform.basis * Vector3(input_dir_2.x, 0, input_dir_2.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
		
	elif direction_2:		
		velocity.x = direction_2.x * SPEED_2
		velocity.z = direction_2.z * SPEED_2
	
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED_2)
		velocity.z = move_toward(velocity.z, 0, SPEED_2)
				
		
	move_and_slide()
