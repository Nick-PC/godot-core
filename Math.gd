extends Node

#returns -1, 0, or 1 to denote normalized "direction" of a value
func normalize(value: float) -> int:
	if value == 0:
		return 0
	else:
		return value / abs(value)

func add_amount_to_until_extreme(value, amount, extreme):
	if amount == 0:
		return value
	elif amount > 0:
		return add_amount_until_maximum(value, amount, extreme)
	else:
		return subtract_amount_until_minimum(value, -1 * amount, extreme)

func subtract_amount_until_minimum(value, amount, minimum):
	return max(value - amount, minimum)

func add_amount_until_maximum(value, amount, maximum):
	return min(value + amount, maximum)
