extends CharacterBody3D

var camera: Camera3D
var weapon_raycast: RayCast3D

var mouse_sensitivity: float = .0015

var jump_velocity: float = 250

var speed: float = 750
var brake_length = 10

#signal weapon_attack

func _ready() -> void:
	camera = $MainCamera
	weapon_raycast = $WeaponRayCast3D
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		if camera:
			var new_angle = camera.rotation.x - (event.relative.y * mouse_sensitivity)
			new_angle = clamp(new_angle, deg_to_rad(-89.0), deg_to_rad(89.0))
			camera.rotation.x = new_angle
			
	if event.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
	
	#if event.is_action_pressed("mouse1"):
		#weapon_attack.emit()
		#print("emit")

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	elif is_on_floor() and Input.is_action_just_pressed("jump"):
		velocity.y = jump_velocity * delta

func _process(delta: float) -> void:
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	
	if velocity.y < 0:
		velocity.y -= .1
	
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var target_velocity = direction * speed * delta
	
	if is_on_floor():
		velocity.x = lerp(velocity.x, target_velocity.x, delta * brake_length)
		velocity.z = lerp(velocity.z, target_velocity.z, delta * brake_length)
	
	move_and_slide()
