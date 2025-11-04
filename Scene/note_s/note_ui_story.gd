extends Control #note_ui_story v1.0

@onready var panel = $ColorRect/Panel
@onready var background = $ColorRect/Panel/Background
@onready var label = $ColorRect/Panel/Label
@onready var button = $ColorRect/Panel/Back
# Animation
@onready var anim = $note_ui_story_animation #ส่วนที่เพิ่มเข้ามาล่าสุด

@onready var player = get_tree().current_scene.get_node("PlayerBody")

func close_with_animation() -> void:
	if not visible:
		return
	anim.play("story_fade_out")
	await anim.animation_finished
	Hide_and_Unpaused()

func Hide_and_Unpaused():
	hide()
	get_tree().paused = false
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _ready() -> void:
	anim.play("RESET")
	hide()
	button.pressed.connect(_on_close_button_pressed)
	print("Close_PC_SCREEN")

func show_note(note_text: String, font_size: int = 24) -> void:
	anim.seek(0, true)
	anim.stop()
	label.text = note_text
	label.add_theme_font_size_override("font_size", font_size)
	show()
	get_tree().paused = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	
func _input(event):
	if visible and event.is_action_pressed("ui_cancel"):
		get_viewport().set_input_as_handled()
		close_with_animation()

func _on_close_button_pressed() -> void:
	close_with_animation()
	print("Close_Note")
