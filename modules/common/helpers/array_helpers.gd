extends Node
class_name ArrayHelpers

static func first(source: Array, callable: Callable, default: Variant = null) -> Variant:
	for element: Variant in source:
		if callable.call(element):
			return element
	return default