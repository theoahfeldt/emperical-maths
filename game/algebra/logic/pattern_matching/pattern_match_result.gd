class_name PatternMatchResult


static func merge(
		a: PatternMatchResult, b: PatternMatchResult) -> PatternMatchResult:
	if a is PatternMatchFailure or b is PatternMatchFailure:
		return PatternMatchFailure.new()
	for name in b.bindings:
		if name in a.bindings:
			if not a.bindings[name].identical_to(b.bindings[name]):
				return PatternMatchFailure.new()
		else:
			a.bindings[name] = b.bindings[name]
	return a
