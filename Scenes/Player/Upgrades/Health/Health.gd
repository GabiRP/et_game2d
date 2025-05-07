class_name GetHealthStrategy
extends BasePlayerStrategy

func apply_upgrade(player: Player) -> bool:
	if !player:
		print("no player")
		return false
	if !player.health:
		print("no player health")
		return false
	player.health.health += 20
	return false
