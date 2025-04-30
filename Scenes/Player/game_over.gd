extends Control

var main_menu: PackedScene = preload("res://Scenes/World/MainMenu/MainMenu.tscn")

func _on_quit_button_pressed() -> void:
	var spawned_menu = main_menu.instantiate()
	get_tree().root.get_node("World").queue_free()
	get_tree().root.add_child(spawned_menu)
	
