extends StaticBody3D #Note v1.1

@export var note_story: bool = false

@export_multiline var note_text: String = "ใส่ข้อความของ Note ที่นี่"
@export var font_size: int = 24 #ปรับขนาดข้อความแต่ละแผ่น
@export_range(0, 3, 1) var correct_answer: int = 0
#Is_answer?
var has_been_answered: bool = false

func interact():
	if has_been_answered:
		print("เคยตอบไปแล้วนิ")
		return
	# Find PlayerUI
	var player = get_tree().current_scene.get_node("PlayerBody")
	if note_story:
		var note_ui_story = player.get_node("player_ui/PlayerUI/note_ui_story")
		note_ui_story.show_note(note_text, font_size)
	else:
		var note_ui = player.get_node("player_ui/PlayerUI/note_ui")
		note_ui.show_note(note_text, font_size)
		has_been_answered = true
	print("Note interact called!")
