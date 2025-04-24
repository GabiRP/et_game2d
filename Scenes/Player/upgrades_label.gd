extends Label

@onready var player: Player = get_owner()

var upgrades: Dictionary = {}

func _on_player_upgrades_updated() -> void:
	var bullet_upgrades: Array[BaseBulletStrategy] = player.upgrades
	var player_upgrades: Array[BasePlayerStrategy] = player.player_upgrades
	upgrades = {}
	for p_upgrade in player_upgrades:
		if upgrades[p_upgrade.upgrade_text]:
			upgrades[p_upgrade.upgrade_text] += 1
		else:
			upgrades[p_upgrade.upgrade_text] = 1
		pass
	
	for b_upgrade in bullet_upgrades:
		if upgrades[b_upgrade.upgrade_text]:
			upgrades[b_upgrade.upgrade_text] += 1
		else:
			upgrades[b_upgrade.upgrade_text] = 1
		pass
	text = ""
	for entry in upgrades.keys():
		text += entry + " " + upgrades[entry] + "\n"
