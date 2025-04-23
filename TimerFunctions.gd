extends Node

func seconds_from_frames(frames: int) -> float:
	return 1.0 * frames / ProjectSettings.get_setting("application/run/max_fps")

func frames_from_seconds(seconds: float) -> int:
	return 1.0 * seconds * ProjectSettings.get_setting("application/run/max_fps")

func wait_frames(frames: int):
	var seconds: float = seconds_from_frames(frames)
	return wait_seconds(seconds)

func wait_seconds(seconds: float):
	return get_tree().create_timer(seconds).timeout

func reduce_timer(timer: Timer, destination_amount: float) -> void:
	if timer.is_stopped():
		timer.start(destination_amount)
	elif timer.time_left > destination_amount:
		timer.start(destination_amount)

func reduce_timer_to_default(timer: Timer) -> void:
	reduce_timer(timer, timer.wait_time)
