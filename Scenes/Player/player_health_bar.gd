extends TextureProgressBar

func _ready() -> void:	
	value = 100

func _on_health_changed(health: float) -> void:
	value = health
