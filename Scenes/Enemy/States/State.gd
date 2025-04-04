class_name State extends Node

@onready var state_machine: StateMachine = get_parent()

signal Transitioned(state: State, new_state_name: String)

func enter() -> void:
	pass

func exit() -> void:
	pass

func update(_delta: float) -> void:
	pass

func physics_update(_delta: float) -> void:
	pass
