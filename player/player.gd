extends CharacterBody3D

const SPEED = 20.0
const JUMP_VELOCITY = 4.5

@onready var stamina: Stamina = %Stamina

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	var sprinting := Input.is_action_pressed("sprint") and stamina.value > 0.0
	stamina.draining = sprinting
	var current_speed := SPEED * (1.6 if sprinting else 1.0)

	var input_dir := Input.get_vector("left", "right", "forward", "backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * current_speed
		velocity.z = direction.z * current_speed
	else:
		velocity.x = move_toward(velocity.x, 0, current_speed)
		velocity.z = move_toward(velocity.z, 0, current_speed)

	move_and_slide()
