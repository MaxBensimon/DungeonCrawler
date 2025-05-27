extends Node3D

var sword_hit: RayCast3D
var sword_has_hit: bool = false

var attack_speed: float = .5

var can_attack: bool = true
var attack_cooldown: bool = false

var is_state_close: bool = false

var sword_swing_sound: AudioStreamPlayer3D
var sword_hit_sound: AudioStreamPlayer3D

func _ready() -> void:
	sword_hit = $Sword1/Sword1HitRayCast3D
	sword_swing_sound = $SwordSwingAudioStreamPlayer3D
	sword_hit_sound = $SwordHitAudioStreamPlayer3D

func _physics_process(_delta: float) -> void:
	if sword_hit.is_colliding() and !sword_has_hit:
		if sword_hit.get_collider().name != 'Player' and !can_attack:
			sword_has_hit = true
			sword_hit_sound.pitch_scale = randf_range(.9, 1.2)
			sword_hit_sound.play()
			print(sword_hit.get_collider())

func _on_weapon_ray_cast_3d_weapon_close() -> void:
	is_state_close = true
	if can_attack:
		$Sword1AnimationTree.change_state_close()

func _on_weapon_ray_cast_3d_weapon_far() -> void:
	is_state_close = false
	if can_attack:
		$Sword1AnimationTree.change_state_far()

func _on_weapon_ray_cast_3d_weapon_attack() -> void:
	if not can_attack:
		return
	
	can_attack = false
	attack_cooldown = true
	sword_swing_sound.pitch_scale = randf_range(.8, 1.2)
	sword_swing_sound.play()
	$Sword1AnimationTree.change_state_attack()
	await get_tree().create_timer(attack_speed).timeout
	
	if is_state_close:
		$Sword1AnimationTree.change_state_close()
	else:
		$Sword1AnimationTree.change_state_idle()
	
	can_attack = true
	attack_cooldown = false
	sword_has_hit = false
