extends CharacterBody2D

const GRAVITY : int = 4200
const JUMP_SPEED : int = -1800

var is_started : bool = false  # Untuk menentukan apakah karakter sudah mulai bergerak

# Fungsi untuk mereset status karakter ke kondisi awal
func reset_game():
	is_started = false
	velocity = Vector2.ZERO  # Reset kecepatan
	$AnimatedSprite2D.play("Idle")  # Kembali ke animasi Idle
	$RunCol.disabled = false  # Aktifkan kembali RunCol

# Dipanggil setiap frame. 'delta' adalah waktu yang berlalu sejak frame sebelumnya.
func _physics_process(delta):
	velocity.y += GRAVITY * delta

	if is_on_floor():
		$RunCol.disabled = false

		if not is_started:
			# Kondisi Idle saat awal game
			$AnimatedSprite2D.play("Idle")
			if Input.is_action_pressed("ui_accept"):  # Jika tombol space ditekan
				is_started = true  # Mulai gerakan
				velocity.y = JUMP_SPEED
				$JumpSound.play()
		else:
			# Setelah start, kondisi Run atau aksi lainnya
			if Input.is_action_pressed("ui_accept"):
				velocity.y = JUMP_SPEED
				$JumpSound.play()
				$AnimatedSprite2D.play("Jump")

			elif Input.is_action_pressed("ui_down"):
				$AnimatedSprite2D.play("Duck")
				$RunCol.disabled = true

			else:
				$AnimatedSprite2D.play("Run")
	else:
		$AnimatedSprite2D.play("Jump")

	move_and_slide()

# Fungsi dipanggil saat tombol restart ditekan
func restart_game():
	reset_game()  # Reset karakter ke kondisi awal
