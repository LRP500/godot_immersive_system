extends Node
class_name ArrayHelpers

static func first(array: Array, callable: Callable, default: Variant = null) -> Variant:
	for element: Variant in array:
		if callable.call(element):
			return element
	return default

static func swap(array: Array[Variant], i: int, j: int) -> void:
	var temp: Variant = array[i]
	array[i] = array[j]
	array[j] = temp