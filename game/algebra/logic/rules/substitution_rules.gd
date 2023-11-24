const SumInverseRightBackward := preload("res://algebra/logic/rules/sum/inverse_right_backward.gd")
const SumInverseLeftBackward := preload("res://algebra/logic/rules/sum/inverse_left_backward.gd")


static func rules() -> Array[SubstitutionRule]:
	return [
		SumInverseRightBackward.new(),
		SumInverseLeftBackward.new(),
	]
