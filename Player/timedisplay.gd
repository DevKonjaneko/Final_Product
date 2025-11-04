extends VBoxContainer

@onready var minute_label = $Time/minute_time
@onready var second_label = $Time/second_time
# Multiply time
@export var time_scale: float = 4.0

var current_minutes = 3
var current_seconds = 0
var time_accumulator = 0.0
#@export var minute_label: String = ""
#@export var second_label: String = ""

func _ready():
	# ตั้งค่าเริ่มต้นให้ Label แสดงเลข 00
	minute_label.text = "03"
	second_label.text = "00"

func _process(delta):
	time_accumulator += delta * time_scale
	
	while time_accumulator >= 1.0:
		current_seconds += 1 
		if current_seconds >= 60:
			current_seconds = 0
			current_minutes += 1
		time_accumulator -= 1.0
		
	minute_label.text = str(current_minutes).pad_zeros(2)
	second_label.text = str(current_seconds).pad_zeros(2)
