class_name Enemy extends CharacterBody2D
#TODO: Hacerlo sin nav mesh, hacer raycast hacia la direccion del jugador y si lo pilla
# mover al enemigo como si fuera un jugador (simulando teclas o algo no se)
@export var movement_speed: float = 5
@export var player: Player
@onready var navigation_agent: NavigationAgent2D = $NavigationAgent2D
@onready var player_raycast: Node = $PlayerRaycast

func _ready() -> void:
	player_raycast.player_detected.connect(_on_player_detected)

func _process(delta: float) -> void:
	set_movement_target(player.global_position)

func set_movement_target(movement_target: Vector2):
	navigation_agent.set_target_position(movement_target)

func set_new_velocity(new_velocity: Vector2, delta: float) -> void:
	var temp_velocity = new_velocity
	if not is_on_floor():
		temp_velocity += get_gravity() * 5 * delta
	velocity = temp_velocity

func _physics_process(delta):
	move_and_slide()

func _on_player_detected(position: Vector2) -> void:
	print("Player detected at %s" % position)
	pass

func raycast(origin: Vector2, to: Vector2) -> Dictionary:
	var space_state = get_world_2d().direct_space_state
	var query = PhysicsRayQueryParameters2D.create(origin, to)
	query.exclude = [self]
	return space_state.intersect_ray(query)
