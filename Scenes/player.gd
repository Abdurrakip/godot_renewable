extends CharacterBody2D

@export var speed: int = 300

var auto_correcting: int = 30
var friction: int = 35

@export var gravity: int = 60
@export var jump_power: int = 1000
var max_jump_num: int = 1
var current_jump_num: int = 0

@export var wall_jump_push: int = 200
@export var wall_slide_gravity: int = 60
var is_wall_sliding: bool = false

var is_facing_right: bool = true
var is_jumping: bool = false
var is_jumping_played: bool = false

@export var face0: Sprite2D
@export var face1: CompressedTexture2D
@export var face2: CompressedTexture2D
@export var face3: CompressedTexture2D

func _ready():
	for items in get_tree().get_nodes_in_group("item"):
		items.connect("collect", collect_sound)
	$music.play()

func collect_sound():
	print("hep")
	$collect.play()

func _process(delta) -> void:
	var input_dir: Vector2 = input()
	
	if !$music.playing:
		$music.play()
	
	if velocity.x < 0 and is_facing_right:
		$".".set_scale(scale * Vector2(-1, 1))
		is_facing_right = false
	if velocity.x > 0 and !is_facing_right:
		$".".set_scale(scale * Vector2(-1, 1))
		is_facing_right = true
		
	if input_dir != Vector2.ZERO:
		accelerate(input_dir)
		$AnimationPlayer.current_animation = "run_right"
		if $walk.playing:
			pass
		else:
			$walk.play()
	else:
		add_friction()
		$AnimationPlayer.current_animation = "idle"
		
	if !is_on_floor() and !is_wall_sliding:
		$AnimationPlayer.current_animation = "jump"
		
	
	if is_wall_sliding:
		$AnimationPlayer.current_animation = "wall_sliding"
		if $slide.playing:
			pass
		else:
			$slide.play()
	player_movement()
	jump()
	wall_slide(delta)
	set_face()
	if !is_wall_sliding:
		$slide.stop()
	if velocity.x == 0:
		$walk.stop()
		


func hurt():
	$head.material.set_shader_parameter("progress", 1)
	$arm.material.set_shader_parameter("progress", 1)
	$arm2.material.set_shader_parameter("progress", 1)
	$leg.material.set_shader_parameter("progress", 1)
	$head/face.material.set_shader_parameter("progress", 1)
	$hurt.play()
	$HurtTimer.start()


func set_face():
	if Globals.solved_poblems == 1:
		face0.texture = face1
	if Globals.solved_poblems == 2:
		face0.texture = face2
	if Globals.solved_poblems == 3:
		face0.texture = face3



func _on_hurt_timer_timeout():
	$head.material.set_shader_parameter("progress", 0)
	$arm.material.set_shader_parameter("progress", 0)
	$arm2.material.set_shader_parameter("progress", 0)
	$leg.material.set_shader_parameter("progress", 0)
	$head/face.material.set_shader_parameter("progress", 0)


func input() -> Vector2:
	var input_dir: Vector2 = Vector2.ZERO
	
	input_dir.x = Input.get_axis("ui_left", "ui_right")
	return input_dir

func accelerate(direction) -> void:
	velocity = velocity.move_toward(speed * direction, auto_correcting)

func add_friction() -> void:
	velocity = velocity.move_toward(Vector2.ZERO, friction)

func player_movement() -> void:
	move_and_slide()

func jump():
	if Input.is_action_just_pressed("ui_up"):
		if current_jump_num < max_jump_num:
			velocity.y = -jump_power
			is_jumping = true
			$AnimationPlayer.current_animation = "jump"
			$jump.play()
			current_jump_num += 1
	else:
		velocity.y += gravity
	
	if is_on_floor():
		current_jump_num = 0
		is_jumping_played = false
	
	if is_on_wall():
		current_jump_num = 0
	
	if is_on_wall() and Input.is_action_pressed("ui_right") and Input.is_action_just_pressed("ui_up"):
		if current_jump_num < max_jump_num:
			velocity.y = -jump_power
			velocity.x = -wall_jump_push
			current_jump_num += 1
	if is_on_wall() and Input.is_action_pressed("ui_left") and Input.is_action_just_pressed("ui_up"):
		if current_jump_num < max_jump_num:
			velocity.y = -jump_power
			velocity.x = wall_jump_push
			current_jump_num += 1

func wall_slide(delta):
	if is_on_wall() and !is_on_floor():
		if Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
			is_wall_sliding = true
		else:
			is_wall_sliding = false
	else:
		is_wall_sliding = false
	
	if is_wall_sliding:
		velocity.y += -wall_slide_gravity * delta
		velocity.y = min(velocity.y, wall_slide_gravity)








