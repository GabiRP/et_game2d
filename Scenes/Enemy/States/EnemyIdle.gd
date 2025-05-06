class_name EnemyIdle extends State

@export var wander_radius: float = 1600
@export var wander_time_window: float = 5
@export var stop_time_window: float = 3
@export var navigation_agent: NavigationAgent2D

@onready var idle_timer: Timer = $IdleTimer
@onready var player_raycast: PlayerRaycast = $"../../PlayerRaycast"

var player: Player
var move_direction: Vector2
var wander_time: float
var stop_time: float
var is_idle: bool

func enter() -> void:
	is_idle = true
	player = get_tree().get_first_node_in_group("Player")
	idle_timer.start(randf_range(1.0, 7.0))
	if !navigation_agent.navigation_finished.is_connected(_on_navigation_ended):
		navigation_agent.navigation_finished.connect(_on_navigation_ended)
	if !idle_timer.timeout.is_connected(_on_rmt_timeout):
		idle_timer.timeout.connect(_on_rmt_timeout)
	if !player_raycast.player_detected.is_connected(_on_player_detected):
		player_raycast.player_detected.connect(_on_player_detected)


func Exit() -> void:
	is_idle = false
	idle_timer.stop()
	player_raycast.player_detected.disconnect(_on_player_detected)
	idle_timer.timeout.disconnect(_on_rmt_timeout)
	pass

#func update(delta: float) -> void:
	#if enemy.is_seeing_player():
		#Transitioned.emit(self, "follow")

func physics_Update(_delta: float) -> void:
	pass 

func _on_rmt_timeout() -> void:
	if state_machine.current_state != self:
		return
	if !navigation_agent.is_navigation_finished():
		return
		
	var random_vector: Vector2 = Vector2(randf_range(-wander_radius, wander_radius),\
	 randf_range(-wander_radius, wander_radius))
	var random_pos: Vector2 =  state_machine.enemy.global_position + random_vector
	var tilemap_layer: TileMapLayer = get_node("/root/World/Foreground")
	var navmap: RID = tilemap_layer.get_navigation_map()
	var navmesh_random_pos: Vector2 = NavigationServer2D.map_get_closest_point(navmap, random_pos)
	state_machine.enemy.set_movement_target(navmesh_random_pos)

func _on_player_detected(_position: Vector2) -> void:
	if state_machine.current_state != self:
		return
	Transitioned.emit(self, "follow")
	pass

func _on_navigation_ended() -> void:
	if !is_idle:
		return
	idle_timer.start(randf_range(3.0, 7.0))
	#print("nav finished")
