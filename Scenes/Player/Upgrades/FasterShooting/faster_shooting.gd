class_name FasterShootingStrategy
extends BasePlayerStrategy

func apply_upgrade(player: Player) -> void:
	var new_cooldown: float = player.attack.start_attack_cooldown - 0.02
	player.attack.start_attack_cooldown = clamp(new_cooldown,\
	0.01, 6)
	pass
