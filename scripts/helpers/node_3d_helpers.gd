class_name Node3dHelpers

static func enable(node: Node3D) -> void:
    node.set_process_mode(Node.PROCESS_MODE_INHERIT)
    node.show()

static func disable(node: Node3D) -> void:
    node.set_process_mode(Node.PROCESS_MODE_DISABLED)
    node.hide()