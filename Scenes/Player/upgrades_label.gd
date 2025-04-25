extends Label

@onready var player: Player = get_owner()

var upgrades: Dictionary = {}

func _on_player_upgrades_updated() -> void:
	var bullet_upgrades: Array[BaseBulletStrategy] = player.upgrades
	var player_upgrades: Array[BasePlayerStrategy] = player.player_upgrades
	upgrades = {}
	for p_upgrade in player_upgrades:
		if upgrades.has(p_upgrade.type):
			upgrades[p_upgrade.type] += 1
		else:
			upgrades[p_upgrade.type] = 1
		pass
	print(upgrades)
	
	for b_upgrade in bullet_upgrades:
		if upgrades.has(b_upgrade.type):
			upgrades[b_upgrade.type] += 1
		else:
			upgrades[b_upgrade.type] = 1
		pass
	print(upgrades)
	text = ""
	for entry in upgrades.keys():
		text += str(entry) + " " + str(upgrades[entry]) + "\n"
