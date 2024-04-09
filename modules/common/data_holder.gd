extends Node
class_name DataHolder

signal data_changed(data: Object)

var data: Object:
    set(new_data):
        data = new_data
        data_changed.emit(data)