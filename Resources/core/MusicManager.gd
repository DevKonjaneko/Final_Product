extends Node

@onready var bgm_player = $AudioStreamPlayer

func play_bgm():
	if not bgm_player.playing:
		bgm_player.play()
		print("BGM Started!")

func stop_bgm():
	if bgm_player.playing:
		bgm_player.stop()
		print("BGM Stopped!")
