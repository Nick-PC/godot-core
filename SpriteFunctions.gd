extends Node

func flash_sprite_n_times(sprite: AnimatedSprite2D, n: int):
	await flash_sprites_n_times([sprite], n)
func flash_sprites_n_times(sprites: Array[AnimatedSprite2D], n: int):
	await flash_sprites_n_times_with_delay(sprites, n, 2)

func flash_sprite_n_times_with_delay(sprite: AnimatedSprite2D, n: int, delay_in_frames: int):
	await flash_sprites_n_times_with_delay([sprite], n, delay_in_frames)
func flash_sprites_n_times_with_delay(sprites: Array[AnimatedSprite2D], n: int, delay_in_frames: int):
	for i in range(n*2):
		for sprite in sprites:
			if sprite != null:
				sprite.visible = !sprite.visible
		await TimerFunctions.wait_frames(delay_in_frames)
	return

func freeze_sprite(sprite: AnimatedSprite2D) -> void:
	return freeze_sprites([sprite])
func freeze_sprites(sprites: Array[AnimatedSprite2D]) -> void:
	for sprite in sprites:
		if sprite != null:
			sprite.speed_scale = 0
	return
