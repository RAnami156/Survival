extends CharacterBody2D

@onready var anim = $AnimatedSprite2D
@onready var marker = $Marker2D
@export var inv: Inv

var speed = 125
var player_state
var bow_equiped = false
var bow_cooldown = true
var arrow_scene = preload("res://arrow.tscn")  # Загружаем сцену стрелы
var mouse_loc_from_player = null

func _physics_process(delta: float) -> void:
	mouse_loc_from_player = get_global_mouse_position() - self.position
	var direction = Vector2.ZERO  # Устанавливаем значение по умолчанию
	
	if !bow_equiped:
		if Input.is_action_pressed("run"):
			speed = 250 
		else:
			speed = 125
		direction = Input.get_vector("left", "right", "up","down")
		if direction.x == 0 and direction.y == 0:
			player_state = "idle" 
		else:
			player_state = "walking"
		velocity = direction * speed
		move_and_slide()
	
	if Input.is_action_just_pressed("right_mouse"):
		bow_equiped = !bow_equiped
		if bow_equiped:
			velocity = Vector2.ZERO  # Останавливаем движение
	
	marker.look_at(get_global_mouse_position())  
	
	if Input.is_action_just_pressed('left_mouse') and bow_equiped and bow_cooldown:
		bow_cooldown = false
		var arrow_instance = arrow_scene.instantiate()  
		arrow_instance.rotation = marker.rotation
		arrow_instance.global_position = marker.global_position
		get_tree().current_scene.add_child(arrow_instance) 
		
		await  get_tree().create_timer(0.4).timeout
		bow_cooldown = true
	
	play_anim(direction)

func play_anim(dir):
	if !bow_equiped:
		if player_state == "idle":
			anim.play("Idle")
		elif player_state == "walking":
			if dir.y == -1:
				anim.play("N-walk")
			elif dir.x == 1:
				anim.play("E-walk")
			elif dir.y == 1:
				anim.play("S-walk")
			elif dir.x == -1:
				anim.play("W-walk")
			if dir.x > 0.5 and dir.y < -0.5:
				anim.play("Ne-walk")
			elif dir.x > 0.5 and dir.y > 0.5:
				anim.play("Se-walk")
			elif dir.x < -0.5 and dir.y > 0.5:
				anim.play("Sw-walk")
			elif dir.x < -0.5 and dir.y < -0.5:
				anim.play("Nw-walk")
	if bow_equiped:
		var x = mouse_loc_from_player.x
		var y = mouse_loc_from_player.y
		if -25 <= x and x <= 25 and y < 0:
			anim.play("N-attack")  
		elif -25 <= x and x <= 25 and y > 0:
			anim.play("S-attack") 
		elif x > 25 and -25 <= y and y <= 25:
			anim.play("E-attack")  
		elif x < -25 and -25 <= y and y <= 25:
			anim.play("W-attack")  
		elif x >= 25 and y <= -25:
			anim.play("Ne-attack")  
		elif x >= 0.5 and y >= 25:
			anim.play("Se-attack")  
		elif x <= -0.5 and y >= 25:
			anim.play("Sw-attack")  
		elif x <= -25 and y <= -25:
			anim.play("Nw-attack")  

func player():
	pass

func collect(item):
	inv.insert(item)
