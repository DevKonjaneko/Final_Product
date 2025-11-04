extends Node3D #hand v1.0
#Text
@onready var interaction_label = get_parent().get_parent().get_node("player_ui/PlayerUI/VBoxContainer/interaction_label")
#Flashlight
@onready var flashlight: SpotLight3D = $SpotLight3D
@export var battery: float = 25.0
@export var battery_drain_rate: float = 1.25
@export var battery_bar_path: NodePath
@onready var battery_bar: ProgressBar = get_node(battery_bar_path)
var is_on: bool = false
#Pick and Drop
var held_object = null
#@onready var hand = $hand
@onready var raycast = $"../RayCast3D"
@onready var ref_position = $ref_position

func _ready() -> void:
	if flashlight:
		flashlight.visible = is_on
	if battery_bar:
		battery_bar.max_value = 100
		battery_bar.value = battery

func _process(delta: float) -> void:
	
	if Input.is_action_just_pressed("Flashlight"):
		toggle_flashlight()
		
	if is_on and battery > 0:
		battery -= battery_drain_rate * delta
		if battery_bar:
			battery_bar.value = battery
		if battery <= 0:
			battery = 0 
			is_on = false
			if flashlight:
				
				flashlight.visible = false
			if battery_bar:
				battery_bar.value = 0
			print("Battery is dead!")
			
	Handle_Object_Pickup()

func toggle_flashlight() -> void:
	if not is_on and battery > 0:
		is_on = true
	else:
		is_on = false
	if flashlight:
		flashlight.visible = is_on

func recharge_battery(amount: float):
	battery += amount
	if battery > 100:
		battery = 100 # ไม่ให้แบตเกิน 100
	if battery:
		battery_bar.value = battery #อัพเดต UI battery
	print("Battery recharge")

func Handle_Object_Pickup() -> void:
	if held_object != null:
		held_object.global_position = ref_position.global_position 
		held_object.global_rotation = ref_position.global_rotation
		if Input.is_action_just_pressed("Interact"):
			if held_object is RigidBody3D:
				held_object.freeze = false
			held_object.collision_layer = 1
			held_object = null
	else:
		if raycast.is_colliding():
			interaction_label.text = "[E] Interact"
			interaction_label.show()
			var object = raycast.get_collider()
			if object and object.is_in_group("Pickupable"):
				if Input.is_action_just_pressed("Interact"):
					held_object = object
					if held_object is RigidBody3D:
						held_object.freeze = true
					held_object.collision_layer = 2
