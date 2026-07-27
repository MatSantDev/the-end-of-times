extends Control

@export var scroll_speed := 40.0

@onready var credits := $MarginContainer/CreditsContainer

func _ready():
	credits.position.y = get_viewport_rect().size.y

func _process(delta):
	credits.position.y -= scroll_speed * delta

	if credits.position.y < -600:
		get_tree().change_scene_to_file("res://scenes/title_screen.tscn")
