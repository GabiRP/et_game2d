class_name PlayerAttack extends Node2D

@export var firing_pos: Marker2D

@onready var player: Player = get_owner()
var bullet_scene: PackedScene = preload("res://Scenes/Bullet/bullet.tscn")

func _physics_process(delta: float) -> void:
	if Input.is_action_just_pressed("attack"):
		var fir_pos: float = -6.0
		if sign(player.last_facing_dir.x) >= 1:
			fir_pos = 6
		firing_pos.position.x = fir_pos
		
		var spawned_bullet: Bullet = bullet_scene.instantiate()
		
		get_tree().root.add_child(spawned_bullet)
		spawned_bullet.global_position = firing_pos.global_position
		spawned_bullet.rotation = player.last_facing_dir.angle()
		spawned_bullet.is_player_bullet = true
		
		for strategy in player.upgrades:
			strategy.apply_upgrade(spawned_bullet)
