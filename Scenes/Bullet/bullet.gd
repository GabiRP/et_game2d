class_name Bullet extends CharacterBody2D

@export var speed: float = 150.0
@export var max_pierce: int = 1

@export var attack: Attack
@export var hit_particles: PackedScene = preload("res://Scenes/Enemy/hit_particles.tscn")

@onready var hurtbox: Hurtbox = $Hurtbox
@onready var anim_player: AnimationPlayer = $AnimationPlayer

var is_player_bullet: bool = false

var current_pierce_count: int = 0

func _ready() -> void:
	if hurtbox:
		hurtbox.hit_enemy.connect(on_enemy_hit)
	anim_player.play("bullet_forward")

func _physics_process(delta: float) -> void:
	var dir = Vector2.RIGHT.rotated(rotation)
		
	velocity = dir*speed
	
	var collision := move_and_collide(velocity*delta)
	
	if collision and collision.get_collider():
		print("pum")
		queue_free()

func on_enemy_hit() -> void:
	current_pierce_count += 1
	var spawned_particles: GPUParticles2D = hit_particles.instantiate()
	get_tree().root.add_child(spawned_particles)
	spawned_particles.global_position = global_position
	spawned_particles.emitting = true
	if current_pierce_count >= max_pierce:
		queue_free()
