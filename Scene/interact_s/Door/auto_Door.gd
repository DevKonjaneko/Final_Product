extends Node3D #Door v2.0

var opened = false
@export var locked = false
@export var albedo_texture: Texture2D
@onready var door_mesh: MeshInstance3D = $hinge/closet_door
@onready var sound_effect: AudioStreamPlayer3D = $CreakingDoor
@onready var sfx_lock: AudioStreamPlayer3D = $DoorLock

func _ready():
	if albedo_texture:
		var new_material = StandardMaterial3D.new()
		new_material.albedo_texture = albedo_texture
		door_mesh.set_surface_override_material(0, new_material)
# Open/Close
func toggle_door():
	if locked:
		print("DoorLocked")
		sfx_lock.play()
		return
	if $AnimationPlayer.is_playing():
		return
	opened = !opened
	if opened:
		$AnimationPlayer.play("door_open")
		sound_effect.play()
	else:
		$AnimationPlayer.play_backwards("door_open")
		sound_effect.play()

# Close (call from Area3D)
func close_door():
	if not opened or $AnimationPlayer.is_playing():
		return
	
	opened = false
	locked = true
	$AnimationPlayer.play_backwards("door_open")
	sound_effect.play()
	print("Door auto-closed")

	await $AnimationPlayer.animation_finished
	sfx_lock.play()

func trigger_door():
	if locked:
		print("DoorLocked")
		sfx_lock.play()
		return
	opened = !opened
	if opened:
		$AnimationPlayer.play("trigger_open")
		sound_effect.play()
		opened = true
	else:
		$AnimationPlayer.play_backwards("trigger_open")
		sound_effect.play()
		opened = false

#Text_UI
func get_interaction_text() -> String:
	if locked:
		return "Locked"
	if opened:
		return "Close Door"
	return "Open Door"

func unlock_door():
	locked = false
	print("Door unlocked")
