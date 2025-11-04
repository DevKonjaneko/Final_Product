extends Node3D

var opened = false
@export var locked = false
@onready var Door_SFX_open: AudioStreamPlayer3D = $GarageDoorOpen
@onready var Door_SFX_close: AudioStreamPlayer3D = $GarageDoorClose
#@onready var Door_SFX_lock: AudioStreamPlayer3D = 

func toggle_door():
	if locked:
		print("DoorLocked")
		#@onready var Door_SFX_lock: AudioStreamPlayer = 
		return
	if $AnimationPlayer.is_playing():
		return
	opened = !opened
	if opened:
		$AnimationPlayer.play("door_open")
		Door_SFX_open.play()
	else:
		$AnimationPlayer.play_backwards("door_open")
		Door_SFX_close.play()
		
func trigger_door():
	if locked:
		print("DoorLocked")
		return
	opened = !opened
	if opened:
		$AnimationPlayer.play("door_open")
		Door_SFX_open.play()
		opened = true
	else:
		$AnimationPlayer.play_backwards("door_open")
		Door_SFX_close.play()
		opened = false

func get_interaction_text() -> String:
	if locked:
		return "Locked" #คืนค่าเป็นข้อความ
	if opened:
		return "Close Door"
		
	return "Open Door"
	
