import pgf.binding
import StringIO

class App:
	"""An application of a function to an argument"""

	def __init__(self, fun, arg):
		self.fun = fun
		self.arg = arg

	def showExpr(self, prec):
		s = self.fun.showExpr(3) + " " + self.arg.showExpr(4)
		if prec > 3:
			s = "(" + s + ")"
		return s

	def __str__(self):
		return self.showExpr(0)

class Lit:
	"""A literal value"""

	def __init__(self, value):
		self.value = value

	def showExpr(self, prec):
		if isinstance(self.value, str):
			return '"' + self.value + '"'
		else:
			return str(self.value)

	def __str__(self):
		return self.showExpr(0)

class Meta:
	"""A meta variable"""

	def __init__(self, metaid):
		self.metaid = metaid

	def showExpr(self, prec):
		return "?"

	def __str__(self):
		return self.showExpr(0)

class Fun:
	"""A function name"""

	def __init__(self, name):
		self.name = name

	def showExpr(self, prec):
		return self.name

	def __str__(self):
		return self.showExpr(0)

class __ExprParser:
	# token types
	TOKEN_UNKNOWN  = 0
	TOKEN_LPARENT  = 1
	TOKEN_RPARENT  = 2
	TOKEN_QUESTION = 3
	TOKEN_IDENT    = 4
	TOKEN_STRING   = 5
	TOKEN_INT      = 6
	TOKEN_FLOAT    = 7
	TOKEN_EOF      = 8

	def __init__(self, fh):
		self.ch = ' '
		self.fh = fh
		self.token = self.TOKEN_UNKNOWN
		self.token_value = ""
		self.readToken()

	def readToken(self):
		while self.ch.isspace():
			self.ch = self.fh.read(1);

		self.token_value = ""

		if self.ch == '(':
			self.ch = self.fh.read(1);
			self.token = self.TOKEN_LPARENT
		elif self.ch == ')':
			self.ch = self.fh.read(1);
			self.token = self.TOKEN_RPARENT
		elif self.ch == '?':
			self.ch = self.fh.read(1);
			self.token = self.TOKEN_QUESTION
		elif (self.ch.isalpha() or self.ch == '_'):
			self.token = self.TOKEN_IDENT
			while (self.ch.isalnum() or self.ch == '_' or self.ch == "'"):
				self.token_value = self.token_value + self.ch
				self.ch = self.fh.read(1)
		elif self.ch == '"':
			self.ch = self.fh.read(1)
			self.token = self.TOKEN_STRING
			while self.ch != '"':
				if self.ch == '':
					raise pgf.ParseError("Missing quotation mark")
				self.token_value = self.token_value + self.ch
				self.ch = self.fh.read(1)
			self.ch = self.fh.read(1)
		elif self.ch.isdigit():
			self.token = self.TOKEN_INT
			while self.ch.isdigit():
				self.token_value = self.token_value + self.ch
				self.ch = self.fh.read(1)
				
			if self.ch == '.':
				self.token = self.TOKEN_FLOAT

				self.token_value = self.token_value + self.ch
				self.ch = self.fh.read(1)
				
				while self.ch.isdigit():
					self.token_value = self.token_value + self.ch
					self.ch = self.fh.read(1)
				
		elif self.ch == '':
			self.token = self.TOKEN_EOF
		else:
			self.token = self.TOKEN_UNKNOWN

	def parseTerm(self):
		if self.token == self.TOKEN_IDENT:
			e = Fun(self.token_value)
			self.readToken()
			return e
		elif self.token == self.TOKEN_LPARENT:
			self.readToken()
			e = self.parseExpr()
			if self.token == self.TOKEN_RPARENT:
				self.readToken()
				return e;
			else:
				raise pgf.ParseError("Missing right parenthesis")
		elif self.token == self.TOKEN_QUESTION:
			e = Meta(0)
			self.readToken()
			return e
		elif self.token == self.TOKEN_STRING:
			e = Lit(self.token_value)
			self.readToken()
			return e
		elif self.token == self.TOKEN_INT:
			e = Lit(int(self.token_value))
			self.readToken()
			return e
		elif self.token == self.TOKEN_FLOAT:
			e = Lit(float(self.token_value))
			self.readToken()
			return e
		else:
			raise pgf.ParseError("Unknown token")

	def parseExpr(self):
		e = self.parseTerm()
		while (self.token != self.TOKEN_EOF and
		       self.token != self.TOKEN_RPARENT):
			e = App(e, self.parseTerm())
		return e

def readExpr_py(str):
	parser = __ExprParser(StringIO.StringIO(str))
	return parser.parseExpr()
