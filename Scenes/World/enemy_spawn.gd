extends Node
class_name EnemySpawn

@onready var spawn_timer: Timer = $Timer

@export var max_spawn_count: int = 6
@export var spawn_pool: Array[PackedScene]

func _ready() -> void:
	spawn_timer.timeout.connect(_on_spawn_timer_timeout)
	pass

func _process(delta: float) -> void:
	pass

func _on_spawn_timer_timeout() -> void:
	var random_int: int = randi_range(0, len(spawn_pool) -1)
	var enemy_scene = spawn_pool[random_int]
	var enemy_count = randi_range(1, max_spawn_count) - 1
	
	for i in range(0, enemy_count):
		var spawn_position: Vector2 = get_random_map_position()
		var spawned_enemy: Enemy = enemy_scene.instantiate()
		get_tree().root.add_child(spawned_enemy)
		spawned_enemy.global_position = spawn_position + Vector2.UP * 15
		pass
	
	spawn_timer.start(randf_range(5, 15))
	pass

func get_random_map_position() -> Vector2:
	var tilemap_layer: TileMapLayer = get_node("/root/World/Foreground")
	var navmap: RID = tilemap_layer.get_navigation_map()
	var navmesh_random_pos: Vector2 = NavigationServer2D.\
	map_get_random_point(navmap, 1, false)
	
	return navmesh_random_pos
