extends RayCast3D

signal weapon_close
signal weapon_far
signal weapon_attack

var has_collided: bool = false

func _input(event: InputEvent) -> void:	
	if event.is_action_pressed("mouse1"):
		if is_colliding():
			return
		weapon_attack.emit()

func _physics_process(_delta: float) -> void:
	if is_colliding() and !has_collided:
		has_collided = true
		weapon_close.emit()
		#print(get_collider())
	elif !is_colliding() and has_collided:
		has_collided = false
		weapon_far.emit()
	
	
