extends RefCounted
class_name WeaponClip

var size: int
var current: int

func _init(_size: int = -1) -> void:
    size = _size
    current = size

func is_empty() -> bool:
    return current == 0

func is_infinite() -> bool:
    return size == -1

func fill() -> void:
    current = size

func add(amount: int) -> void:
    if !is_infinite():
        current = min(current + amount, size)

func remove(amount: int) -> void:
    if !is_infinite():
        current = max(current - amount, 0)