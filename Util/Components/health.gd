class_name Health 
extends Node

signal health_changed(health: float)

@export var hitbox: Hitbox
@export var animation_player: AnimationPlayer

@export var max_health: float = 100.0
@onready var health: float = max_health

@onready var parent: Node2D = get_owner()

func _ready() -> void:
	assert(parent is not Enemy or parent is not Player)
	if hitbox:
		print("higbox")
		hitbox.damaged.connect(on_damaged)

func on_damaged(attack: Attack) -> void:
	if !parent.alive:
		return

	health = clampf(health - attack.damage, 0, max_health)
	print(attack.damage)
	health_changed.emit(health)
	print(health)
	if health <= 0:
		health = 0
		parent.alive = false
		parent.queue_free()
		#if animation_player:
			#animation_player.play("death")
