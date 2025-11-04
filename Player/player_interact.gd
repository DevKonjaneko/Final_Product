extends RayCast3D #player_interact.gd

@onready var interaction_label = get_parent().get_parent().get_node("player_ui/PlayerUI/VBoxContainer/interaction_label")

func _ready():
	interaction_label.hide()

func _physics_process(_delta: float) -> void:
	if is_colliding():
		var hit = get_collider()
		#= PickupableItem =
		if hit.is_in_group("Battery"):
			handle_pickup_battery(hit)
			interaction_label.text = "[E] Pick-up"
			interaction_label.show()
		elif hit.name == "DoorKey":
			handle_pickup_door_key(hit)
			interaction_label.text = "[E] Pick-up"
			interaction_label.show()
		#= Static Objects =
		elif hit.name == "door_static":
			handle_door(hit)
		elif hit.name == "garage_door":
			handle_garage_door(hit)
		elif hit.name == "washing_machine":
			handle_washing_machine(hit)
		elif hit.name == "garden_gate_r":
			handle_garden_gate(hit)
		elif hit.name == "garden_gate_l":
			handle_garden_gate(hit)
		elif hit.name == "light_switch":
			handle_light_switch(hit)
		elif hit.name == "door_bell":
			handle_door_bell(hit)
		elif hit.name == "closet_door_l":
			handle_closet_door(hit)
		elif hit.name == "closet_door_r":
			handle_closet_door(hit)
		elif hit.name == "Washbasin_drawer_upper":
			handle_Washbasin_drawer(hit)
		elif hit.name == "Washbasin_drawer_lower":
			handle_Washbasin_drawer(hit)
		elif hit.is_in_group("Note"):
			handle_note(hit)
		elif hit.name == "toilet":
			handle_toilet(hit)
		else:
			interaction_label.hide()
	else:
		interaction_label.hide()

# = PickupableItem =
func handle_pickup_battery(hit: Node3D) -> void:
	if Input.is_action_just_pressed("Interact"):
		var interaction_area = get_parent().get_parent().get_node("InteractionArea")
		for item_data in interaction_area.ItemTypes:
			if item_data.ItemModelPrefab != null and item_data.ItemModelPrefab.resource_path == hit.scene_file_path:
				interaction_area.OnItemPickedUp.emit(item_data)
				hit.queue_free()
				print("Picked up: ", item_data.ItemName)
				return
		printerr("Item not found in ItemTypes")
	else:
		interaction_label.hide()
func handle_pickup_door_key(hit: Node3D) -> void:
	if Input.is_action_just_pressed("Interact"):
		var interaction_area = get_parent().get_parent().get_node("InteractionArea")
		for item_data in interaction_area.ItemTypes:
			if item_data.ItemName == "DoorKey":
				interaction_area.OnItemPickedUp.emit(item_data)
				hit.queue_free()
				print("Picked up: ", item_data.ItemName)
				return
		printerr("Item not found in ItemTypes")
	else:
		interaction_label.hide()

# = IteractItems =
func handle_note(hit: Node3D) -> void:
	interaction_label.text = "[E] Read"
	interaction_label.show()
	if Input.is_action_just_pressed("Interact"):
		hit.interact()
		print("Read Note")

# = UTILITIES =
func handle_light_switch(hit: Node3D) -> void:
	interaction_label.text = "[E] Interact"
	interaction_label.show()
	if Input.is_action_just_pressed("Interact"):
		hit.get_parent().toggle_light()
func handle_door_bell(hit: Node3D) -> void:
	interaction_label.text = "[E] Interact"
	interaction_label.show()
	if Input.is_action_just_pressed("Interact"):
		hit.get_parent().ring_bell()

# = Door =
func handle_door(hit: Node3D) -> void:
	var door_script = hit.get_parent().get_parent().get_parent()
	var text = door_script.get_interaction_text()
	interaction_label.text = "[E] " + text
	interaction_label.show()
	if Input.is_action_just_pressed("Interact"):
		hit.get_parent().get_parent().get_parent().toggle_door()
func handle_closet_door(hit: Node3D) -> void:
	if hit.name == "closet_door_l":
		interaction_label.text = "[E] Interact"
		interaction_label.show()
		if Input.is_action_just_pressed("Interact"):
			hit.get_parent().get_parent().toggle_door_left()
	elif hit.name == "closet_door_r":
		interaction_label.text = "[E] Interact"
		interaction_label.show()
		if Input.is_action_just_pressed("Interact"):
			hit.get_parent().get_parent().toggle_door_right()
func handle_garden_gate(hit: Node3D) -> void:
	if hit.name == "garden_gate_r":
		var d_script = hit.get_parent().get_parent()
		var text = d_script.get_right_door_text()
		interaction_label.text = "[E] " + text 
		interaction_label.show()
		if Input.is_action_just_pressed("Interact"):
			hit.get_parent().get_parent().toggle_right_door()
	elif hit.name == "garden_gate_l":
		var d_script = hit.get_parent().get_parent()
		var text = d_script.get_left_door_text()
		interaction_label.text = "[E] " + text
		interaction_label.show()
		if Input.is_action_just_pressed("Interact"):
			hit.get_parent().get_parent().toggle_left_door()
func handle_garage_door(hit: Node3D) -> void:
	var door_script = hit.get_parent().get_parent().get_parent()
	var text = door_script.get_interaction_text()
	interaction_label.text = "[E] " + text
	interaction_label.show()
	if Input.is_action_just_pressed("Interact"):
		hit.get_parent().get_parent().get_parent().toggle_door()

# = Objests =
func handle_Washbasin_drawer(hit: Node3D) -> void:
	if hit.name == "Washbasin_drawer_upper":
		var d_script = hit.get_parent().get_parent()
		var text = d_script.get_drawer_upper_text()
		interaction_label.text = "[E] " + text
		interaction_label.show()
		if Input.is_action_just_pressed("Interact"):
			hit.get_parent().get_parent().toggle_drawer_upper()
	elif hit.name == "Washbasin_drawer_lower":
		var d_script = hit.get_parent().get_parent()
		var text = d_script.get_drawer_lower_text()
		interaction_label.text = "[E] " + text
		interaction_label.show()
		if Input.is_action_just_pressed("Interact"):
			hit.get_parent().get_parent().toggle_drawer_lower()
func handle_washing_machine(hit: Node3D) -> void:
	interaction_label.text = "[E] Open Door"
	interaction_label.show()
	if Input.is_action_just_pressed("Interact"):
		hit.get_parent().get_parent().get_parent().toggle_door()
func handle_toilet(hit: Node3D) -> void:
	interaction_label.text = "[E] Interact"
	interaction_label.show()
	if Input.is_action_just_pressed("Interact"):
		hit.get_parent().get_parent().get_parent().toggle()
