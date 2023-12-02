extends Node

func seconds_from_frames(frames):
	return 1.0 * frames / ProjectSettings.get_setting("application/run/max_fps")

func wait_frames(frames):
	var seconds = seconds_from_frames(frames)
	return wait_seconds(seconds)

func wait_seconds(seconds):
	return get_tree().create_timer(seconds).timeout
