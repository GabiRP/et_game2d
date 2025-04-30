class_name PlayerAttackAreaE2 extends Area2D

@onready var enemy: Enemy = get_owner()
@onready var attack_timer: Timer = $AttackTimer
@onready var player_raycast: PlayerRaycast = enemy.get_node("PlayerRaycast")
@onready var firing_pos: Marker2D = $BulletDir
@onready var hit_particles: GPUParticles2D = $HitParticles

@onready var bullet_scene: PackedScene = preload("res://Scenes/Bullet/bullet_enemy2.tscn")

@export var damage: int = 20

func _ready() -> void:
	pass

func _physics_process(_delta: float) -> void:
	if has_overlapping_bodies():
		var first_body = get_overlapping_bodies().get(0)
		if first_body is Player:
			do_attack(first_body)
	pass

func _process(_delta: float) -> void:
	pass

func do_attack(player: Player) -> void:
	if !player_raycast.is_detecting_player:
		return
	if attack_timer.time_left <= 0:
		var fir_pos: float = -1.0
		if sign(enemy.last_facing_dir.x) >= 1:
			fir_pos = 1.0
		firing_pos.position.x = fir_pos
		var spawned_bullet: Bullet = bullet_scene.instantiate()
		get_tree().root.add_child(spawned_bullet)
		spawned_bullet.global_position = firing_pos.global_position
		var rot = firing_pos.global_position.direction_to(player.hitbox.global_position)\
			.angle()
		spawned_bullet.rotation = rot
		spawned_bullet.is_player_bullet = false
		attack_timer.start(2)
