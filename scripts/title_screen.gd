extends Control


func _on_start_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/tutorial.tscn")



func _on_credits_btn_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/credit_screen.tscn")


func _on_exit_btn_pressed() -> void:
	get_tree().quit()
