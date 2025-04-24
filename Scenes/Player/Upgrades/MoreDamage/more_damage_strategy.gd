extends BaseBulletStrategy
class_name MoreDamageStrategy

func apply_upgrade(body: Bullet) -> void:
	body.attack.damage += 2
