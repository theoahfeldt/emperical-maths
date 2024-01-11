class_name PatternMatchResult


var _bindings: Dictionary
var _failed := false


func pretty_string() -> String:
	if _failed:
		return "No match"
	else:
		return str(_bindings)


static func match(bindings: Dictionary) -> PatternMatchResult:
	var new := PatternMatchResult.new()
	new._bindings = bindings
	return new


static func no_match() -> PatternMatchResult:
	var new := PatternMatchResult.new()
	new._failed = true
	return new


static func merge(
		a: PatternMatchResult, b: PatternMatchResult) -> PatternMatchResult:
	if a._failed or b._failed:
		return PatternMatchResult.no_match()
	for name in b._bindings:
		if name in a._bindings:
			if not a._bindings[name].identical_to(b._bindings[name]):
				return PatternMatchResult.no_match()
		else:
			a._bindings[name] = b._bindings[name]
	return a
