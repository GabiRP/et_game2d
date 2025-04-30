extends Node

##################################################
# Similar to the movement component. The actual 
# animations are handled through an AnimationTree 
# for the player, but parameters are updated here.
##################################################

@export var animation_tree : AnimationTree
@export var sprite : Sprite2D
@export var animation_player: AnimationPlayer
@export var enemy_hitbox: Hitbox

@onready var enemy : Enemy = get_owner()
@onready var damage_timer: Timer = $Timer
var last_facing_dir: Vector2 = Vector2(0,1)

var idle: bool = true

func _ready():
	# The animation tree is inactive while outside of gameplay.
	# This makes it easier to edit animations in the editor.
	animation_tree.active = true
	enemy_hitbox.damaged.connect(_on_damaged)


func _physics_process(_delta: float) -> void:
	if !enemy.alive:
		animation_tree.active = false
		return
	
	idle = !enemy.velocity.x
	if !idle:
		last_facing_dir = sign(enemy.velocity)
	enemy.last_facing_dir = last_facing_dir
	var time_scale = .5
	animation_tree.set("parameters/TimeScale/scale", time_scale)
	animation_tree.set("parameters/AnimationNodeStateMachine/Idle/blend_position", sign(last_facing_dir.x))
	animation_tree.set("parameters/AnimationNodeStateMachine/Walk/blend_position", sign(last_facing_dir.x))

func _on_damaged(_attack: Attack) -> void:
	damage_timer.start(.1)
	sprite.modulate.a = .5
	await damage_timer.timeout
	sprite.modulate.a = 1
	#await damage_timer.timeout
	#sprite.modulate.a = .7
	#await damage_timer.timeout
	#sprite.modulate.a = 1
