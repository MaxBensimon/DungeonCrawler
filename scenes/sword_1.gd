extends Node3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.name != 'Player':
	
		$Sword1AnimationTree.change_state_close()
		print('Sword collided with ' + str(body.name))

func _on_area_3d_body_exited(body: Node3D) -> void:
	if body.name != 'Player':
		$Sword1AnimationTree.change_state_far()
		await get_tree().create_timer(5).timeout
		$Sword1AnimationTree.change_state_idle()
		print('Sword exited')
