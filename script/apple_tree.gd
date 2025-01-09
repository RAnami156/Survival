extends Node2D

@onready var anim = $AnimatedSprite2D
@onready var timer = $growth_timer
var state = "no apples"
var player_in_area = false
var apple = preload("res://scene/apple_collectable.tscn")

func _ready() -> void:
	timer.wait_time = 3  # Устанавливаем таймер на 10 секунд
	timer.start()

func _process(delta: float) -> void:
	if state == "no apples":
		anim.play("no-apples")
	elif state == "apples":
		anim.play("apples")
		if player_in_area and Input.is_action_just_pressed("e"):
			state = "no apples"
			drop_apple()

func _on_pickable_area_body_entered(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = true

func _on_pickable_area_body_exited(body: Node2D) -> void:
	if body.has_method("player"):
		player_in_area = false

func _on_growth_timer_timeout() -> void:
	if state == "no apples":
		state = "apples"

func drop_apple() -> void:
	var apple_instance = apple.instantiate()
	apple_instance.global_position = $Marker2D.global_position
	get_parent().add_child(apple_instance)
	timer.start()  # Перезапуск таймера
