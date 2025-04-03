class_name Player extends CharacterBody2D


@export var SPEED: float = 300.0
@export var SPRINT_SPEED: float = 400.0
@export var JUMP_VELOCITY: float = -400.0

var aim_position : Vector2 = Vector2(1, 0)

var alive: bool = true

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		var half_viewport = get_viewport_rect().size / 2.0
		aim_position = (event.position - half_viewport)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("left", "right")
	var speed: float = SPEED
	if Input.is_action_pressed("sprint"):
		speed = SPRINT_SPEED
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_slide()
