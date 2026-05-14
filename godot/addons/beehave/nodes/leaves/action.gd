@tool
@icon("../../icons/action.svg")
class_name ActionLeaf extends Leaf


func get_class_name() -> Array[StringName]:
	var classes := super()
	classes.push_back(&"ActionLeaf")
	return classes
