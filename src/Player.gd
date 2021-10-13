extends KinematicBody2D


const SPEED := 350
const GRAVITY := 450

export var jump_impulse := -1200

var velocity := Vector2(0, 0)

func _physics_process(delta: float) -> void:
	reset_gravity_on_floor()
	set_animation_and_speed(delta)
	if is_on_ceiling():
		velocity.y = 100
	var _ignored = move_and_slide(velocity, Vector2(0, -1))
	if not is_on_floor():
		$AnimatedSprite.play("jump")
	velocity.x = lerp(velocity.x, 0, 0.15)


func reset_gravity_on_floor() -> void:
	if is_on_floor():
		velocity.y = 500


func set_animation_and_speed(delta: float) -> void:
	if Input.is_action_pressed("left"):
		velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
	elif Input.is_action_pressed("right"):
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")
	if Input.is_action_pressed("crouch"):
		$AnimatedSprite.play("duck")
		if velocity.x < 0:
			velocity.x += 200
		elif velocity.x > 0:
			velocity.x -= 200
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y += jump_impulse
	else:
		velocity.y += GRAVITY * 3 * delta
