import pgf
import sys
import sets
import readline

sys.stdout.write("loading...")
sys.stdout.flush();
gr = pgf.readPGF("../../../treebanks/PennTreebank/ParseEngAbs.pgf")
sys.stdout.write("\n")

source_lang = gr.languages["ParseEng"]
target_lang = gr.languages["ParseBul"]

we = pgf.readExpr("UttImpSg PPos (ImpVP (UseV try_V))")
print source_lang.linearize(we)

sys.stdout.write("start cat: "+gr.startCat+"\n\n")

class Completer():
	def __init__(self, lang):
		self.gr = lang
		
	def complete(self, prefix, state):
		if state == 0:
			line = readline.get_line_buffer()
			line = line[0:readline.get_begidx()]
			self.i = source_lang.getCompletions(line, prefix=prefix)
			self.tokens = sets.Set()

		if len(self.tokens) > 50:
			return None

		while True:
			try:
				(p,t) = self.i.next()
				if t not in self.tokens:
					self.tokens.add(t)
					return t
			except StopIteration:
				return None

completer = Completer(source_lang)
readline.set_completer(completer.complete)
readline.parse_and_bind("tab: complete")

while True:
	try:
		line = raw_input("> ");
	except EOFError:
		sys.stdout.write("\n")
		readline.set_completer(None)
		break
	except KeyboardInterrupt:
		sys.stdout.write("\n")
		readline.set_completer(None)
		break

	try:
		for (p,e) in source_lang.parse(line, n=1):
			sys.stdout.write("["+str(p)+"] "+str(e)+"\n")
			print target_lang.linearize(e)
	except pgf.ParseError as e:
		print e.message
