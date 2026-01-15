extends CharacterBody3D

const SPEED = 5.0

# Recuperiamo il valore della gravità dalle impostazioni del progetto (di solito è 9.8)
var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# --- PARTE 1: GRAVITÀ ---
	# Se NON siamo sul pavimento (is_on_floor è falso), applichiamo la gravità.
	if not is_on_floor():
		# Sottraiamo la gravità dalla velocità verticale (Y)
		# Moltiplichiamo per 'delta' per rendere la caduta fluida su tutti i computer
		velocity.y -= gravity * delta

	# --- PARTE 2: MOVIMENTO (uguale a prima) ---
	var input_dir = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	# Muove il corpo e gestisce le collisioni
	move_and_slide()
