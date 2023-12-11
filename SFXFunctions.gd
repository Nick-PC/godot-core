extends Node

func play_sound_on_player(sound: AudioStream, player : AudioStreamPlayer):
	player.stream = sound
	player.play()
