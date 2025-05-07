extends BasePlayerStrategy
class_name MovementSpeedStrategy

func apply_ugprade(body: Player) -> bool:
	body.SPEED += 10
	return true
