extends Node3D
# variable
@export var is_open = false

func toggle():
	if $AnimationPlayer.is_playing():
		return
		
	is_open = !is_open
	
	if is_open:
		$AnimationPlayer.play("open")
		#sound_effect.play()
	else:
		$AnimationPlayer.play_backwards("open")
		#sound_effect.play()
