class_name ItemDropper
extends Node

@onready var enemy: Enemy = get_owner()

@export var item_pool: Array[PackedScene]
@export_range(0, 1, .01) var spawn_probability: float = 0.75

func _on_health_died() -> void:
	if randf_range(0, 1) <= spawn_probability:
		spawn_random_upgrade()
	pass

func spawn_random_upgrade() -> void:
	var random_int: int = randi_range(0, len(item_pool) -1)
	var current_pos = enemy.global_position
	var selected_item = item_pool[random_int].instantiate()
	
	get_tree().root.add_child(selected_item)
	selected_item.global_position = current_pos + Vector2.UP * 15
