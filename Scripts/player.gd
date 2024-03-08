extends CharacterBody2D


const speed = 300.0
const jump_power = -1000.0
var jump_count = 0
@export var max_jumps = 1
# Get the gravity from the project settings to be synced with RigidBody nodes.
#var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
const acceleration = 50
const friction = 70
@export var fallMultiplier = 10
@export var lowJumpMultiplier = 10 
@export var jumpVelocity = 1000 #Jump height

#Physics
@export var gravity = 8
func _physics_process(_delta):
	var input_dir: Vector2 = input()
	if input_dir != Vector2.ZERO:
		accelerate(input_dir)
		#play_animation()
	else:
		add_friction()
		#idle animation
	#Applying gravity to player
	velocity.y += gravity
	#Jumping
	jump() 
	if is_on_floor():
		jump_count = 0
	player_movement()
	#debug velocity printer
	print(velocity)
func input():
	var input_dir = Vector2.ZERO
	
	input_dir.x = Input.get_axis("ui_left","ui_right")
	return input_dir

func  accelerate(direction):
	velocity = velocity.move_toward(speed * direction, acceleration)

	
func add_friction():
	velocity = velocity.move_toward(Vector2.ZERO,friction)
	
func player_movement():
	move_and_slide()
func play_animation():
	pass
func jump():
	#Jump Physics
	if velocity.y > 0: # Player is falling
		velocity += Vector2.UP * (-9.81) * (fallMultiplier) # Falling action is faster than jumping action | Like in mario

	elif velocity.y < 0 && Input.is_action_just_released("ui_up"): # Player is jumping 
		velocity += Vector2.UP * (-9.81) * (lowJumpMultiplier) # Jump Height depends on how long you will hold key

	if is_on_floor() or jump_count < max_jumps:
		if Input.is_action_just_pressed("ui_up"): 
			velocity = Vector2.UP * jumpVelocity # Normal Jump action
			jump_count += 1
				
