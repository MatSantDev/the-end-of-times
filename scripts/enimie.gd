extends CharacterBody2D

class_name Enemy

var player_ref = null

@onready var hitbox: Area2D = $Hitbox

@export_category("Variables")
@export var speed: float = 30
var is_dead: bool = false



func _physics_process(_delta: float) -> void:
	if player_ref != null:
		var direction: Vector2 = global_position.direction_to(player_ref.global_position)
		velocity = speed * direction
		move_and_slide()


func _on_detection_area_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_ref = body


func _on_detection_area_body_exited(body: Node2D) -> void:
	if body.is_in_group("player"):
		player_ref = null
