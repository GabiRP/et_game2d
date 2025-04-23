class_name PlayerAttack extends Node2D

@export var firing_pos: Marker2D
@export var start_attack_cooldown: float = .5
@export var max_bullet_count: int = 30

var bullet_count: int = 30

@onready var player: Player = get_owner()
@onready var attack_timer: Timer = $AttackTimer
var bullet_scene: PackedScene = preload("res://Scenes/Bullet/bullet.tscn")

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("attack"):
		player.shooting = true
		if attack_timer.time_left > 0:
			return
		#if bullet_count <= 0:
			#attack_timer.start(2)
			#bullet_count = max_bullet_count
			#return
		#bullet_count -= 1
		attack_timer.start(start_attack_cooldown)
		var fir_pos: float = -9.0
		if sign(player.last_facing_dir.x) >= 1:
			fir_pos = 9
		firing_pos.position.x = fir_pos
		
		var spawned_bullet: Bullet = bullet_scene.instantiate()
		
		get_tree().root.add_child(spawned_bullet)
		spawned_bullet.global_position = firing_pos.global_position
		spawned_bullet.rotation = player.last_facing_dir.angle()
		spawned_bullet.is_player_bullet = true
		
		for strategy in player.upgrades:
			strategy.apply_upgrade(spawned_bullet)
		return
	player.shooting = false
