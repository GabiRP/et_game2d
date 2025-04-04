class_name EnemyIdle extends State

@export var wander_radius: float = 15
@export var wander_time_window: float = 5
@export var stop_time_window: float = 3

var move_direction: Vector2
var wander_time: float
var stop_time: float

func randomize_wander() -> void:
	move_direction = Vector2(randf_range(-wander_radius, wander_radius), 0)
	wander_time = randf_range(1, wander_time_window)

func enter() -> void:
	randomize_wander()

func update(delta: float) -> void:
	if wander_time > 0:
		wander_time -= delta
	else:
		randomize_wander()
	

func physics_update(delta: float) -> void:
	if state_machine.enemy:
		state_machine.enemy.set_new_velocity(move_direction * state_machine.enemy.movement_speed, delta)
