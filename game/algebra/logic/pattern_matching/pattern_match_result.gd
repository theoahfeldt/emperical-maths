class_name PatternMatchResult


static func merge(
		a: PatternMatchResult, b: PatternMatchResult) -> PatternMatchResult:
	if a is PatternMatchFailure or b is PatternMatchFailure:
		return PatternMatchFailure.new()
	for name in b.assignments:
		if name in a.assignments:
			if not a.assignments[name].identical_to(b.assignments[name]):
				return PatternMatchFailure.new()
		else:
			a.assignments[name] = b.assignments[name]
	return a
