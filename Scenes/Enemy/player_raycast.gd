extends Node

signal player_detected(position: Vector2)

@onready var enemy: Enemy = get_owner()
@onready var enemy_head: Node2D = enemy.get_node("Head")
@export var detection_distance: float = 500.0

func _ready() -> void:
	pass 

func _physics_process(delta: float) -> void:
	var raycast = enemy.raycast(enemy_head.global_position, enemy.player.global_position)
	if raycast:
		var collider = raycast["collider"]
		if collider is Player:
			if enemy_head.global_position.distance_to(collider.global_position) > detection_distance:
				return
			player_detected.emit(collider.global_position)
	pass
