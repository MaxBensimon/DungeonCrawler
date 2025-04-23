extends CharacterBody3D

var mouse_sensitivity = .25
const SPEED = 5.0
const JUMP_VELOCITY = 4.5

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	var input_dir := Input.get_vector("left", "right", "forward", "back")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()

func _input(event):
	if event is InputEventMouseMotion:
		handle_mouse_motion(event)
	if event.is_action_pressed("esc"):
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func handle_mouse_motion(event: InputEventMouseMotion):
	rotate_y(deg_to_rad(-event.relative.x * mouse_sensitivity))
	$Camera3D.rotate_x(deg_to_rad(-event.relative.y * mouse_sensitivity))
	$Camera3D.rotation.x = clamp($Camera3D.rotation.x, deg_to_rad(-85), deg_to_rad(85))
