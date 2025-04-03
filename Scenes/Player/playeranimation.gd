extends Node

@export var animation_tree : AnimationTree
@export var sprite : Sprite2D

@onready var player : Player = get_owner()

var last_facing_dir: Vector2 = Vector2(0,-1)

func _ready():
	# The animation tree is inactive while outside of gameplay.
	# This makes it easier to edit animations in the editor.
	animation_tree.active = true


func _physics_process(delta: float) -> void:
	if !player.alive:
		animation_tree.active = false
		return
	var idle = !player.velocity
	if !idle:
		last_facing_dir = player.aim_position

	var time_scale: float = 1
	last_facing_dir = player.aim_position
	#TODO: Replace this with a nested AnimationTree/AnimationStateMachine

	animation_tree.set("parameters/TimeScale/scale", time_scale)
	animation_tree.set("parameters/AnimationNodeStateMachine/WalkDirection/blend_position", sign(last_facing_dir.x))
	animation_tree.set("parameters/AnimationNodeStateMachine/IdleDirection/blend_position", sign(last_facing_dir.x))
	animation_tree.set("parameters/AnimationNodeStateMachine/Jump/blend_position", sign(last_facing_dir.x))
