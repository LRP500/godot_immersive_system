class_name CanvasHelpers

static func set_enable(node: Control, enabled: bool) -> void:
    if enabled:
        enable(node)
    else:
        disable(node)

static func enable(node: Control) -> void:
    node.set_process_mode(Node.PROCESS_MODE_INHERIT)
    node.show()

static func disable(node: Control) -> void:
    node.set_process_mode(Node.PROCESS_MODE_DISABLED)
    node.hide()