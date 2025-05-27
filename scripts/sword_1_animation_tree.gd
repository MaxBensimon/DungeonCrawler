extends AnimationTree

enum {
	IDLE,
	CLOSE,
	FAR,
	ATTACK,
}

var state
var playback: AnimationNodeStateMachinePlayback

func _ready() -> void:
	playback = get("parameters/playback") as AnimationNodeStateMachinePlayback
	#change_state_idle()

func change_state_idle():
	state = IDLE
	playback.travel("idle")
	print('idle')

func change_state_close():
	state = CLOSE
	playback.travel("close")
	print('close')

func change_state_far():
	state = FAR
	playback.travel("far")
	print('far')

func change_state_attack():
	state = ATTACK
	playback.travel("attack")
	print('attack')
