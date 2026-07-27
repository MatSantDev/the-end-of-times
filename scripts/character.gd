extends CharacterBody2D

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var hitbox: Area2D = $Hitbox

@export_category("Variables")
@export var speed: float = 70
var target_velocity := Vector2.ZERO
@export var acceleration: float = 10
@export var deceleration: float = 20

var animation: String = ""
var state = PlayerState.IDLE
var direction = DirectionState.DOWN
var input_direction := Vector2.ZERO
var last_direction := Vector2.ZERO

@export_category("Objects")
@export var bullet_zzz : PackedScene

enum PlayerState {
	IDLE,
	WALK,
	ATTACK,
	DASH,
	HURT,
	DEAD
}

enum DirectionState {
	DOWN,
	UP,
	SIDE
}

func _physics_process(_delta: float) -> void:
	get_iput()
	attack()
	update_state()
	update_direction()
	animation_play()
	move_and_slide()
	



func animation_play():
	match state:
		PlayerState.IDLE:
			animation = "idle_"
		PlayerState.WALK:
			animation = "walk_"

	match direction:
		DirectionState.DOWN:
			animation += "down"
		DirectionState.UP:
			animation += "up"
		DirectionState.SIDE:
			animation += "side"
			
	anim.play(animation)

func get_iput():
	input_direction = Input.get_vector("left","right", "up","down")
	target_velocity = input_direction * speed
	
	if input_direction != Vector2.ZERO:
		velocity = velocity.move_toward(target_velocity, acceleration)
	else:
		velocity = velocity.move_toward(Vector2.ZERO, deceleration)

func update_state():
	if input_direction != Vector2.ZERO:
		last_direction = input_direction
		state = PlayerState.WALK
	else:
		state = PlayerState.IDLE

func update_direction():
	if abs(last_direction.x) > abs(last_direction.y):
		direction = DirectionState.SIDE
		anim.flip_h = last_direction.x < 0
	else:
		direction = DirectionState.DOWN if last_direction.y > 0 else DirectionState.UP


func _on_hitbox_area_entered(_area: Area2D) -> void:
	pass
	
func attack():
	if Input.is_action_just_pressed("click"):
		
		var zzz = bullet_zzz.instantiate()

		zzz.global_position = global_position + Vector2(12,-17)
		zzz.direction = last_direction

		get_tree().current_scene.add_child(zzz)
