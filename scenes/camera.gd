extends Camera3D

var player

var tilt_limit: float = .1
var tilt_speed: float = 2

var bob_amount: float = .1
var bob_speed: float = 10
var bob_phase: float = 0
var camera_height: float = 0.675

func _ready() -> void:
	player = $".."

func _process(delta: float) -> void:
	# Tilt
	if Input.is_action_pressed("left"):
		rotation.z = lerp(rotation.z, tilt_limit, tilt_speed * delta)
	elif Input.is_action_pressed("right"):
		rotation.z = lerp(rotation.z, -tilt_limit, tilt_speed * delta)
	else:
		rotation.z = lerp(rotation.z, 0.0, tilt_speed * delta * 2)
	
	# Viewbob
	var is_moving = Input.is_action_pressed("forward") or Input.is_action_pressed("back") or Input.is_action_pressed("left") or Input.is_action_pressed("right")
	if is_moving and player.is_on_floor():
		bob_phase += bob_speed * delta
		var bob_offset = sin(bob_phase) * bob_amount
		transform.origin.y = bob_offset + camera_height
	else:
		transform.origin.y = lerp(transform.origin.y, camera_height, bob_speed * delta)
		bob_phase = 0
	
