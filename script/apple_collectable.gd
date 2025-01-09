extends StaticBody2D

@onready var sprite = $AnimationPlayer

var apple_count = 0

func _ready() -> void:
	fallfromtree()

func fallfromtree() :
	sprite.play("fallingfromtree")
	await  get_tree().create_timer(1.5).timeout
	sprite.play("fade")
	await  get_tree().create_timer(0.3).timeout
	queue_free()
	apple_count += 1
	print("apple: ", apple_count, "🍎")
