extends Node

##################################################
# Similar to the movement component. The actual 
# animations are handled through an AnimationTree 
# for the player, but parameters are updated here.
##################################################

@export var animation_tree : AnimationTree
@export var sprite : Sprite2D
@export var player_hitbox: Hitbox

@onready var player : Player = get_owner()
@onready var damage_timer: Timer = $Timer

var last_facing_dir: Vector2 = Vector2(0,1)

func _ready():
	# The animation tree is inactive while outside of gameplay.
	# This makes it easier to edit animations in the editor.
	animation_tree.active = true
	player_hitbox.damaged.connect(_on_damaged)


func _physics_process(delta: float) -> void:
	if !player.alive:
		animation_tree.active = false
		return
	
	last_facing_dir = player.last_facing_dir
	
	var time_scale = 1
	if player.running:
		time_scale *= 1.5
	
	if last_facing_dir.x <= -1:
		sprite.flip_h = true
	else: sprite.flip_h = false
	
	animation_tree.set("parameters/TimeScale/scale", time_scale)

func _on_damaged(_attack: Attack) -> void:
	damage_timer.start(.1)
	sprite.modulate.a = .5
	await damage_timer.timeout
	sprite.modulate.a = 1
	#await damage_timer.timeout
	#sprite.modulate.a = .7
	#await damage_timer.timeout
	#sprite.modulate.a = 1
