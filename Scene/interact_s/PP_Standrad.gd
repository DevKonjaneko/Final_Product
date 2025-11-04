extends Node3D
@onready var anim = $AnimationPlayer
@export var toggle_to : Node3D

func _on_area_3d_body_entered(body: Node3D):
	if not body.is_in_group("self") and not body.is_in_group("Player"):
		print("ตัวรับน้ำหนักทำงาน")
		anim.play("press")
		if toggle_to:
			toggle_to.locked = false
		if toggle_to:
			toggle_to.trigger_door()
		
func _on_area_3d_body_exited(body: Node3D):
	if not body.is_in_group("self") and not body.is_in_group("Player"):
		print("กลับสู่สถานะปกติ")
		anim.play_backwards("press")
		if toggle_to:
			toggle_to.trigger_door()
		if toggle_to:
			toggle_to.locked = true
