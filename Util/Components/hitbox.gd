class_name Hitbox
extends Area2D

@export var is_player: bool

signal damaged(attack: Attack)

func damage(attack: Attack) -> void:
	print(attack.damage)
	damaged.emit(attack)
