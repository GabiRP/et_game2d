class_name PlayerAttackArea extends Area2D

@onready var enemy: Enemy = get_owner()
@onready var attack_timer: Timer = $AttackTimer
@onready var player_raycast: PlayerRaycast = enemy.get_node("PlayerRaycast")
@onready var firing_pos: Marker2D = $BulletDir
@onready var hit_particles: GPUParticles2D = $HitParticles

func _ready() -> void:
	pass

func _physics_process(delta: float) -> void:
	if has_overlapping_bodies():
		var first_body = get_overlapping_bodies().get(0)
		if first_body is Player:
			do_attack(first_body)
	pass

func _process(delta: float) -> void:
	pass

func do_attack(player: Player) -> void:
	if !player_raycast.is_detecting_player:
		return
	if attack_timer.time_left <= 0:
		print("attacking")
		var att: Attack = Attack.new()
		att.damage = 50
		player.get_node("Hitbox").damage(att)
		hit_particles.global_position = player.global_position
		hit_particles.emitting = true
		attack_timer.start(2)
