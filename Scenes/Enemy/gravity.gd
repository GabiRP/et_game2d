extends Node
@onready var enemy: Enemy = get_owner()
func _physics_process(delta: float) -> void:
	if !enemy.is_on_floor():
		enemy.velocity.y += enemy.get_gravity().y * delta
		enemy.move_and_slide()
