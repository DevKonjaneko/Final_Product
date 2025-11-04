extends InteractableItem #Doorkey v1.0
class_name InteractableKey
@export var ItemName: String = "Item"
@export_enum("Pickup", "Read", "Open", "Examine")
var interaction_type: String = "Pickup"

func interact():
	print("Item Name = ", ItemName)
	queue_free()
