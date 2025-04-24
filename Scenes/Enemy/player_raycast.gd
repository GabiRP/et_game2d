class_name PlayerRaycast extends Node

signal player_detected(position: Vector2)

@onready var enemy: Enemy = get_owner()
@onready var enemy_head: Node2D = enemy.get_node("Head")
@export var detection_distance: float = 500.0
@export var detection_fov = 110

var is_detecting_player: bool = false

func _ready() -> void:
	pass 

func _physics_process(_delta: float) -> void:
	if !enemy.player.alive:
		return
	var raycast = enemy.raycast(enemy_head.global_position, enemy.player.global_position)
	var forward_vector: Vector2
	var sprite: Sprite2D = enemy.get_node("Sprite2D")
	if sprite.flip_h:
		forward_vector = Vector2(1, 0)
	else:
		forward_vector = Vector2(-1, 0)
	
	if raycast:
		var collider = raycast["collider"]
		if collider is Player:
			if !enemy_head or !collider:
				return
			var dir_to_player = enemy_head.global_position.direction_to(collider.global_position)
			if acos(forward_vector.dot(dir_to_player)) > deg_to_rad(detection_fov):
				is_detecting_player = false
				return
			if enemy_head.global_position.distance_to(collider.global_position) > detection_distance:
				is_detecting_player = false
				return
			player_detected.emit(collider.global_position)
			is_detecting_player = true
		else:
			is_detecting_player = false
	pass
