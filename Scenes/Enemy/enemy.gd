class_name Enemy extends CharacterBody2D
#TODO: Hacerlo sin nav mesh, hacer raycast hacia la direccion del jugador y si lo pilla
# mover al enemigo como si fuera un jugador (simulando teclas o algo no se)
@export var movement_speed: float = 250
@export var player: Player
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var player_raycast: Node = $PlayerRaycast

func _ready() -> void:
	navigation_agent.velocity_computed.connect(Callable(_on_velocity_computed))
	player_raycast.player_detected.connect(_on_player_detected)

func _process(delta: float) -> void:
	set_movement_target(player.global_position)

func set_movement_target(movement_target: Vector2):
	navigation_agent.set_target_position(movement_target)

func _physics_process(delta):
	# Do not query when the map has never synchronized and is empty.
	if NavigationServer2D.map_get_iteration_id(navigation_agent.get_navigation_map()) == 0:
		return
	if navigation_agent.is_navigation_finished():
		return

	var next_path_position: Vector2 = navigation_agent.get_next_path_position()
	var new_velocity: Vector2 = global_position.direction_to(next_path_position) * movement_speed
	
	if navigation_agent.avoidance_enabled:
		navigation_agent.set_velocity(new_velocity)
	else:
		_on_velocity_computed(new_velocity)

func _on_velocity_computed(safe_velocity: Vector2):
	velocity = safe_velocity
	move_and_slide()

func _on_player_detected(position: Vector2) -> void:
	print("Player detected at %s" % position)
	pass

func raycast(origin: Vector2, to: Vector2) -> Dictionary:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(origin, to)
	query.exclude = [self]
	return space_state.intersect_ray(query)
