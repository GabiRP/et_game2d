class_name Hurtbox
extends Area2D

signal hit_enemy

@onready var bullet: Bullet = get_owner()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	area_entered.connect(on_area_entered)

func on_area_entered(area: Area2D) -> void:
	print("area")
	if area is Hitbox:
		if area.is_player and !bullet.is_player_bullet:
			area.damage(bullet.attack)
			hit_enemy.emit()
			return
		area.damage(bullet.attack)
		hit_enemy.emit()
