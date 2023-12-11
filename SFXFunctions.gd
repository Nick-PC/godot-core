extends Node

@onready var default_player = $DefaultPlayer

func play_sound_on_player(sound: AudioStream, player : AudioStreamPlayer):
	player.stream = sound
	player.play()

func play_sound(sound: AudioStream):
	play_sound_on_player(sound, default_player)
