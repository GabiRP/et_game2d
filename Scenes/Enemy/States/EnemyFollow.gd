class_name EnemyFollow extends State

@onready var player_raycast: Node = $"../../PlayerRaycast"
@onready var follow_timer: Timer = $FollowTimer

func enter() -> void:
	player_raycast.player_detected.connect(_on_player_detected)
	follow_timer.start(5)
	follow_timer.timeout.connect(
		func():
			Transitioned.emit(self, "idle")
	)
	pass

func _on_player_detected(position: Vector2) -> void:
	if state_machine.enemy.global_position.distance_squared_to(position) > 5000:
		state_machine.enemy.set_movement_target(position)
		return
