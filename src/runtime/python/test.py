import sys
import pgf

sys.stdout.write("loading...")
sys.stdout.flush();
gr = pgf.readPGF("../../../treebanks/PennTreebank/ParseEngAbs.pgf")
sys.stdout.write("\n")

we = pgf.readExpr("UttImpSg PPos (ImpVP (UseV try_V))")
print gr.languages["ParseEng"].linearize(we)

sys.stdout.write("start cat: "+gr.startCat+"\n\n")

while True:
	sys.stdout.write("> ")
	line = sys.stdin.readline();
	if line == '':
		sys.stdout.write("\n")
		break;

	try:
		for (p,e) in gr.languages["ParseEng"].parse(line, n=5):
			sys.stdout.write("["+str(p)+"] "+str(e)+"\n")
			print gr.languages["ParseEngBul"].linearize(e)
	except pgf.ParseError as e:
		print e.message
