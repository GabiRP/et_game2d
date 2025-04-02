extends CharacterBody2D

@export var speed: float = 400

func _physics_process(delta: float) -> void:
	if !is_on_floor():
		velocity = get_gravity() * delta
	var dir = Input.get_vector("left", "right", "up", "down")
	velocity += dir * speed
	move_and_slide()
