extends CanvasLayer

@onready var sub_viewport = $background/SubViewportContainer/SubViewport
@onready var load_game_button = $Control/MarginContainer/VBoxContainer/VBoxContainer/LoadGame_Button

func _ready():
	MusicManager.play_bgm()
	load_game_button.disabled = true
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	var current_res = globalsetting.current_resolution
	sub_viewport.size = Vector2(current_res.x, current_res.y)

func _on_new_game_button_pressed():
	MusicManager.stop_bgm()
	get_tree().change_scene_to_file("res://Scene/_main_s/MainScene.tscn")

func _on_load_game_button_pressed():
	pass
	MusicManager.stop_bgm()
	
func _on_option_button_pressed():
	get_tree().change_scene_to_file("res://ui/mainmenu/options.tscn")

func _on_control_button_pressed():
	get_tree().change_scene_to_file("res://ui/mainmenu/control.tscn")

func _on_credit_button_pressed():
	get_tree().change_scene_to_file("res://ui/mainmenu/credits.tscn")

func _on_quit_button_pressed():
	get_tree().quit()
