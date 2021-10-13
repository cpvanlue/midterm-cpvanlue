extends KinematicBody2D


const SPEED := 500
const GRAVITY := 450

export var jump_impulse := -1700

var velocity := Vector2(0, 0)

func _physics_process(delta: float) -> void:
	reset_gravity_on_floor()
	set_direction()
	check_abilities(delta)
	if is_on_ceiling():
		velocity.y = 100
	var _ignored = move_and_slide(velocity, Vector2(0, -1))
	if not is_on_floor():
		$AnimatedSprite.play("jump")
	velocity.x = lerp(velocity.x, 0, 0.15)
	$Hitbox.scale.y = 1
	$Hitbox.position.y = 50


func reset_gravity_on_floor() -> void:
	if is_on_floor():
		velocity.y = 980


func set_direction() -> void:
	if Input.is_action_pressed("left"):
		velocity.x = -SPEED
		if Input.is_action_pressed("sprint"):
			velocity.x = -SPEED * 1.5
		$AnimatedSprite.flip_h = true
		$AnimatedSprite.play("walk")
	elif Input.is_action_pressed("right"):
		velocity.x = SPEED
		if Input.is_action_pressed("sprint"):
			velocity.x = SPEED * 1.5
		$AnimatedSprite.flip_h = false
		$AnimatedSprite.play("walk")
	else:
		$AnimatedSprite.play("idle")


func check_abilities(delta: float) -> void:
	if Input.is_action_pressed("crouch") and is_on_floor():
		$AnimatedSprite.play("duck")
		$Hitbox.scale.y = 0.3
		$Hitbox.position.y = 65
		velocity.x = velocity.x / 2
	if Input.is_action_just_pressed("jump") and is_on_floor():
		if Input.is_action_pressed("sprint"):
				velocity.y += jump_impulse * 1.15
		else:
			velocity.y += jump_impulse
	else:
		velocity.y += GRAVITY * 3 * delta
