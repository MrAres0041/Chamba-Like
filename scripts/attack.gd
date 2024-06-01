extends AnimatedSprite2D


func _physics_process(delta):
	var in_dir = Vector2(Input.get_action_strength("ui_left") - Input.get_action_strength("ui_right"),
	Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
	dir_atk(in_dir)
	
			
	
func dir_atk(dir):
	match dir:
		Vector2.UP:
			rotation_degrees = 0
			play("slash_1", 2.0)
			_on_animation_finished()
		Vector2.DOWN:
			rotation_degrees = 180
		Vector2.LEFT:
			rotation_degrees = 90
		Vector2.RIGHT:
			rotation_degrees = 270
		


func _on_animation_finished():
	stop()
