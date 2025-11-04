extends Node3D #Photography v1.0
# Texture
@export var picture_texture: Texture2D
@onready var mesh_instance = $Photography/MeshInstance3D

# Rigidbody3d
@onready var photography: RigidBody3D = $Photography

func _ready() -> void:
	photography.freeze = true
	
	var material = StandardMaterial3D.new()
	material.albedo_texture = picture_texture
	mesh_instance.set_surface_override_material(0, material)
