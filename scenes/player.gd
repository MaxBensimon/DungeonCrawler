extends CharacterBody3D

var camera: Camera3D

#var anim: AnimationPlayer

var mouse_sensitivity: float = .0015
var rotation_speed: float = 2

var speed: float = 250
var brake_length = 10

#var jump_velocity: float = 4
#var air_control_factor: float = 2
#var is_jumping: bool = false
#var was_in_air: bool = false
#var has_landed: bool = false

func _ready() -> void:
	camera = $Camera
	#anim = $Camera/AnimationPlayer
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		if camera:
			camera.rotate_x(-event.relative.y * mouse_sensitivity)
			camera.rotation.x = clamp(camera.rotation.x, -1.5, 1.5)
			
	if event.is_action_pressed("ui_cancel"):  # "ui_cancel" is typically mapped to the Escape key
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	var input_dir := Input.get_vector("left", "right", "forward", "back")
	
	if not is_on_floor():
		velocity += get_gravity() * delta
		#input_dir *= air_control_factor
		#was_in_air = true
		#has_landed = false
	#else:
		#input_dir *= 1.0
		#if was_in_air and not has_landed:
			##anim.play("Landingbob")
			#has_landed = true
			#was_in_air = false
#
	#if Input.is_action_just_pressed("jump") and is_on_floor():
		#velocity.y = jump_velocity
		#is_jumping = true
	
	if velocity.y < 0:
		velocity.y -= .1
	
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	var target_velocity = direction * speed * delta
	
	if is_on_floor():
		velocity.x = lerp(velocity.x, target_velocity.x, delta * brake_length)
		velocity.z = lerp(velocity.z, target_velocity.z, delta * brake_length)
	#else:
		#velocity.x = lerp(velocity.x, target_velocity.x, delta * air_control_factor)
		#velocity.z = lerp(velocity.z, target_velocity.z, delta * air_control_factor)
	
	move_and_slide()
