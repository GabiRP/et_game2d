class_name BasePlayerStrategy
extends Resource

@export var texture: Texture2D = preload("res://Scenes/Player/latest.png")
@export var upgrade_text: String = "Base"
@export var type: String = "base"

func apply_upgrade(_player: Player) -> bool:
	return true
