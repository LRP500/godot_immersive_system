class_name NodeHelpers

static func find_in_parents(node: Node, pattern: String, recursive: bool = false) -> Node:
    var result: Node = null
    var parent: Node = node.get_parent()
    if !recursive:
        return parent.get_node_or_null(pattern)
    while result == null:
        result = parent.get_node_or_null(pattern)
        parent = parent.get_parent()
        if parent == node.get_tree().get_root():
            break
    return result