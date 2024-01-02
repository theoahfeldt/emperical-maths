extends Resource


@export var rule_ordering: Array[Script]

var _rank: Dictionary


func initialize() -> void:
	for i in range(rule_ordering.size()):
		_rank[rule_ordering[i]] = i


func sorted_unique(rules: Array[AlgebraicRule]) -> Array[AlgebraicRule]:
	rules.sort_custom(compare)
	var unique: Array[AlgebraicRule] = []
	var previous_rank: int = -1
	for rule in rules:
		if rank(rule) != previous_rank:
			unique.append(rule)
		previous_rank = rank(rule)
	return unique


func compare(a: AlgebraicRule, b: AlgebraicRule) -> bool:
	return rank(a) < rank(b)


func rank(rule: AlgebraicRule) -> int:
	return _rank[rule.get_script()]
