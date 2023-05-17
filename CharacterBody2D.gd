extends CharacterBody2D

const SPEED = 300.0
const JUMP = -600.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var GRAVITY = 1200
# gravity by default_gravity is 980 by using (ProjectSettings.get_setting("physics/2d/default_gravity"))

# note: const = variable value cannot change
# note: var = value can change
# note: delta (in function below) = amount of frame/time elapsed

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# Handle Jump.
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = JUMP
		
	$MarkerPivot.look_at(get_global_mouse_position())
	# I am proud of this one to be honest, "aiming system separate from caracter sprite"
	# Setting one node as pivot for the .look_at and then another node (sprite2D in this case) as the pointing direction
	# Set up two marker node, oneas pivot one as the pointer, works fine

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
