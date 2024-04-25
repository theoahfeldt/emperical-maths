class_name Tokenizer


var _text: String
var _index: int = 0


static func tokenize(text: String) -> Array[Token]:
	var tokenizer := Tokenizer.create(text)
	var tokens: Array[Token] = []
	var next := tokenizer.next_token()
	while next:
		tokens.append(next)
		next = tokenizer.next_token()
	return tokens


static func create(text: String) -> Tokenizer:
	var new := Tokenizer.new()
	new._text = text
	return new


func next_token() -> Token:
	if _index >= len(_text):
		return null
	var token := tokenize_SymbolToken()
	if token:
		return token
	token = tokenize_integer()
	if token:
		return token
	return tokenize_variable()


func tokenize_SymbolToken() -> Token:
	if _text.substr(_index, 2) == "=>":
		_index += 2
		return ImpliesToken.new()
	var token: Token
	match _text[_index]:
		"(":
			token = LeftParenthesisToken.new()
		")":
			token = RightParenthesisToken.new()
		"+":
			token = PlusToken.new()
		"-":
			token = MinusToken.new()
		"=":
			token = EqualsToken.new()
		"^":
			token = CaretToken.new()
		_:
			return null
	_index += 1
	return token


func tokenize_integer() -> Token:
	var regex := RegEx.create_from_string("^[0-9]+")
	var regex_match := regex.search(_text.substr(_index))
	if regex_match:
		var string := regex_match.get_string()
		_index += len(string)
		return IntegerToken.create(int(string))
	return null


func tokenize_variable() -> Token:
	var regex := RegEx.create_from_string("^[a-z]")
	var regex_match := regex.search(_text.substr(_index))
	if regex_match:
		var string := regex_match.get_string()
		_index += len(string)
		return VariableToken.create(string)
	return null
