class_name EnemyFollow extends State

@onready var player_raycast: PlayerRaycast = $"../../PlayerRaycast"
@onready var follow_timer: Timer = $FollowTimer

func enter() -> void:
	if !player_raycast.player_detected.is_connected(_on_player_detected):
		player_raycast.player_detected.connect(_on_player_detected)
	follow_timer.start(5)
	follow_timer.timeout.connect(
		func():
			if state_machine.current_state != self:
				return
			Transitioned.emit(self, "idle")
	)
	pass

func exit() -> void:
	player_raycast.player_detected.disconnect(_on_player_detected)

func _on_player_detected(position: Vector2) -> void:
	if state_machine.current_state != self:
		return
	if state_machine.enemy.global_position.distance_squared_to(position) > 5000:
		state_machine.enemy.set_movement_target(position)
