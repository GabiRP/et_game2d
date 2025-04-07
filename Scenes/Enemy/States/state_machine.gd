class_name StateMachine extends Node

@export var initial_state: State
@export var enemy: Enemy

var current_state: State
var states: Dictionary = {}

func _ready() -> void:
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.Transitioned.connect(_on_child_transition)
			print(child.name.to_lower())
		if initial_state:
			initial_state.enter()
			current_state = initial_state

func _process(delta: float) -> void:
	if current_state:
		current_state.physics_update(delta)

func _on_child_transition(state, new_state_name) -> void:
	if state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		return
	
	if current_state:
		current_state.exit()
	
	new_state.enter()
	current_state = new_state
	print(new_state)
