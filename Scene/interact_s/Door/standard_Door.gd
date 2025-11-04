extends Node3D #Door v2.0

var opened = false
@export var locked = false

@export var albedo_texture: Texture2D
@onready var sfx_lock: AudioStreamPlayer3D = $DoorLock
@onready var sfx_open: AudioStreamPlayer3D = $CreakingDoor
@onready var door_mesh: MeshInstance3D = $hinge/closet_door

func ai_enable_door(body):
	if body.name == "rabbitNPC" and !locked and $AnimationPlayer.current_animation != "door_open":
		opened = true
		$AnimationPlayer.play("door_open")
		
func ai_disable_door(body):
	if body.name == "rabbitNPC" and !locked and $AnimationPlayer.current_animation != "door_open":
		opened = false
		$AnimationPlayer.play_backwards("door_open")

func _ready():
	if albedo_texture:
		var new_material = StandardMaterial3D.new()
		new_material.albedo_texture = albedo_texture
		door_mesh.set_surface_override_material(0, new_material)

func toggle_door():
	if locked:
		print("DoorLocked")
		sfx_lock.play()
		return
	if $AnimationPlayer.is_playing():
		return
	opened = !opened
	if opened:
		$AnimationPlayer.play("trigger_open")
		sfx_open.play()
		opened = true
	else:
		$AnimationPlayer.play_backwards("trigger_open")
		sfx_open.play()
		opened = false

func trigger_door():
	if locked:
		print("DoorLocked")
		sfx_lock.play()
		return
	opened = !opened
	if opened:
		$AnimationPlayer.play("trigger_open")
		sfx_open.play()
		opened = true
	else:
		$AnimationPlayer.play_backwards("trigger_open")
		sfx_open.play()
		opened = false

func get_interaction_text() -> String:
	if locked:
		return "Locked"
	if opened:
		return "Close Door"
	return "Open Door"

func unlock_door():
	locked = false
	print("Door unlocked")
