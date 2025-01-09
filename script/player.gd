extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@export var inv: Inv

var speed = 125
var player_state


func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("run"):
		speed = 250 
	else:
		speed = 125
	var direction = Input.get_vector("left", "right", "up","down")
	
	if direction.x== 0 and direction.y == 0 :
		player_state = "idle" 
	elif direction.x != 0 or direction.y != 0 :
		player_state = "walking"
		
	velocity = direction * speed
	move_and_slide()
	
	play_anim(direction)
	
func play_anim(dir):
	if player_state == "idle" :
		anim.play("Idle")
	if player_state == "walking" :
		if dir.y == -1:
			anim.play("N-walk")
		if dir.x == 1:
			anim.play("E-walk")
		if dir.y == 1:
			anim.play("S-walk")
		if dir.x == -1:
			anim.play("W-walk")
			
		if dir.x > 0.5 and dir.y < -0.5 :
			anim.play("Ne-walk")
		if dir.x > 0.5 and dir.y > 0.5 :
			anim.play("Se-walk")
		if dir.x < -0.5 and dir.y > 0.5 :
			anim.play("Sw-walk")
		if dir.x < -0.5 and dir.y < -0.5 :
			anim.play("Nw-walk")
			
func player():
	pass

func collect(item):
	inv.insert(item)
