extends BaseBulletStrategy
class_name MoreDamageStrategy

@export var damage_to_add: int = 1

func apply_upgrade(body: Bullet) -> void:
	body.attack.damage += damage_to_add
