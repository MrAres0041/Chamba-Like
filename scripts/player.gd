extends CharacterBody2D

var an_state
var an_tree

var en_atk_range: bool
var en_atk_cd: bool

func player():
	pass

func _ready():
	an_tree = get_node("AnimationTree")
	an_state = an_tree.get("parameters/playback")
	
func _physics_process(delta):
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	#Capture direction
	var in_dir = Vector2(
		Input.get_action_strength("d") - Input.get_action_strength("a"),
		Input.get_action_strength("s") - Input.get_action_strength("w"),
		)
	
	#Can walk?
	if !GlobalPlayer.chatting and !GlobalPlayer.attacking:
		velocity = in_dir.normalized() * GlobalPlayer.speed
		move_and_slide()
		update_an(in_dir)
		

#Walking/Idle
func update_an(dir):
	if(dir != Vector2.ZERO):
		an_state.travel("walk")
		an_tree.set("parameters/idle/blend_position", dir)
		an_tree.set("parameters/walk/blend_position", dir)
	else:
		an_state.travel("idle")

#Combat zone

func _on_hit_box_body_entered(body):
	if body.has_method("enemy"):
		en_atk_range = true


func _on_hit_box_body_exited(body):
	if body.has_method("enemy"):
		en_atk_range = false

func enemy_atk():
	pass
