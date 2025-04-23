extends Label

@export var full_health_color: Color
@export var mid_health_color: Color
@export var low_health_color: Color
@export var full_health: float
@export var mid_health: float
@export var low_health: float

func _ready() -> void:	
	var label_settings_new: LabelSettings = label_settings.duplicate()
	label_settings = label_settings_new
	text = str(int(100))
	set_color(100)

func _on_health_changed(health: float) -> void:
	text = str(int(health))
	set_color(health)

func set_color(health_val: float) -> void:
	if health_val >= full_health:
		label_settings.font_color = full_health_color
	elif health_val >= mid_health:
		label_settings.font_color = mid_health_color
	else:
		label_settings.font_color = low_health_color
