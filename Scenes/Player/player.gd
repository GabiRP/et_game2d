class_name Player extends CharacterBody2D

signal upgrades_updated

@export var SPEED: float = 300.0
@export var SPRINT_SPEED: float = 400.0
@export var JUMP_VELOCITY: float = -400.0

@onready var game_over: Control = $"CanvasLayer/GameOver"
@onready var hitbox: Hitbox = $Hitbox
@onready var attack: PlayerAttack = $PlayerAttack
var alive: bool = true
var running: bool = false
var invincible: bool = false
var shooting: bool = false

var last_facing_dir: Vector2 = Vector2(-1,0)

var upgrades: Array[BaseBulletStrategy] = []
var player_upgrades: Array[BasePlayerStrategy] = []

func _process(_delta: float) -> void:
	pass

func _physics_process(delta: float) -> void:
	if !alive:
		return
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
	running = false
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	if velocity.x and !shooting:
		last_facing_dir.x = sign(velocity.x)
	move_and_slide()

func show_gameover() -> void:
	alive = false
	game_over.visible = true

func add_bullet_upgrade(upgrade: BaseBulletStrategy) -> void:
	upgrades.append(upgrade)
	upgrades_updated.emit()
func add_player_upgrade(upgrade: BasePlayerStrategy) -> void:
	player_upgrades.append(upgrade)
	upgrades_updated.emit()
