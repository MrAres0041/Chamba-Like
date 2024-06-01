extends CharacterBody2D

var dir
var speed = 50
var player = null
var chase = false
var an_state
var an_tree

func enemy():
	pass

func _ready():
	#Animation Variables
	an_tree = get_node("AnimationTree")
	an_state = an_tree.get("parameters/playback")
	dir = Vector2.ZERO
	
func _physics_process(delta):
	#Chase player
	if chase:
		dir = (player.position - position).normalized()
		velocity = dir * speed
		move_and_slide()
	update_an(dir)
#DetectionZone
func _on_area_2d_body_entered(body):
	player = body
	chase = true

	
func _on_area_2d_body_exited(body):
	player = null
	chase = false
	#To fix anim idle stuck
	#May be better ways to do it, but here it is
	dir = Vector2.ZERO
	
func update_an(dir):
	
	if(dir != Vector2.ZERO):
		an_state.travel("walk")
		an_tree.set("parameters/idle/blend_position", dir)
		an_tree.set("parameters/walk/blend_position", dir)
	else:
		an_state.travel("idle")
