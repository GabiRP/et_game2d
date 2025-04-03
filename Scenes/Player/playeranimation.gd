extends Node

@export var animation_tree : AnimationTree
@export var sprite : Sprite2D

@onready var player : Player = get_owner()

func _ready():
	# The animation tree is inactive while outside of gameplay.
	# This makes it easier to edit animations in the editor.
	animation_tree.active = true


func _physics_process(delta: float) -> void:
	if !player.alive:
		animation_tree.active = false
		return
	
	var velocity = player.velocity
	
	#TODO: Replace this with a nested AnimationTree/AnimationStateMachine
	
	if velocity:
		var time_scale = 1
		
		if sign(player.aim_position.x) != sign(player.velocity.x):
			time_scale = -1
		
		animation_tree.set("parameters/TimeScale/scale", time_scale)
		animation_tree.set("parameters/WalkDirection/blend_position", sign(player.aim_position.x))
	else:
		animation_tree.set("parameters/TimeScale/scale", 1)
		animation_tree.set("parameters/WalkDirection/blend_position", 0)
	
