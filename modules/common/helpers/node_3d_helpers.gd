class_name Node3dHelpers

static func set_enable(node: Node3D, enabled: bool) -> void:
    if enabled:
        enable(node)
    else:
        disable(node)

static func enable(node: Node3D) -> void:
    node.set_process_mode(Node.PROCESS_MODE_INHERIT)
    node.show()

static func disable(node: Node3D) -> void:
    node.set_process_mode(Node.PROCESS_MODE_DISABLED)
    node.hide()

static func get_child_of_type(node: Node3D, type: String) -> Node3D:
    for child in node.get_children():
        if child.is_class(type):
            return child
    return null

static func get_children_of_type(node: Node3D, type: String) -> Array[Node3D]:
    var result: Array[Node3D] = []
    for child in node.get_children():
        if child.is_class(type):
            result.append(child)
    return result