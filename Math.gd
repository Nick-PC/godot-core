extends Node

#returns -1, 0, or 1 to denote normalized "direction" of a value
func normalize(value):
	if value == 0:
		return 0
	else:
		return value / abs(value)
