extends AnimationTree

enum {
	IDLE,
	WALK,
	CLOSE,
	FAR,
	ATTACK,
}

var state

func _ready() -> void:
	change_state_idle()

func change_state_idle():
	state = IDLE
	print(state)

func change_state_walk():
	state = WALK
	print(state)

func change_state_close():
	state = CLOSE
	print(state)

func change_state_far():
	state = FAR
	print(state)

func change_state_attack():
	state = ATTACK
	print(state)
