extends Node
class_name MainMenu
var world: PackedScene = preload("res://Scenes/World/World.tscn")

func _on_start_button_pressed() -> void:
	var spawned_world: World = world.instantiate()
	var mainmenu: Control = get_tree().root.get_node("MainMenu")
	mainmenu.queue_free()
	get_tree().root.add_child(spawned_world)
	pass

func _on_quit_button_pressed() -> void:
	get_tree().quit()
	pass
