#include <algorithm>
#include <cctype>
#include <cstdlib>
#include <fstream>
#include <iomanip>
#include <ios>
#include <iostream>
#include <iterator>
#include <map>
#include <set>
#include <stdexcept>
#include <string>
#include <vector>
#include <list>
#include <time.h>
#include <stdio.h>
 
using std::cin ;
using std::cout ;
using std::endl ;
using std::equal ;
using std::find_if ;
using std::getline ;
using std::istream ;
using std::logic_error ;
using std::map ;
using std::max ;
using std::multimap ;
using std::rand ;
using std::set ;
using std::setw ;
using std::sort ;
using std::streamsize ;
using std::string ;
using std::vector ;
using std::list ;


typedef vector<string> Wordlist ;
typedef map<string,int> Lexicon ;
typedef vector<int> Sentence ;
typedef int Tree ;
typedef vector<Sentence> Linearizer ;
typedef map<Sentence,vector<Tree> > Parser ;

// interpreter of compact translation lists, generated in GF by
// tb -compact. AR 22/9/2006

// map words to indices
Sentence getSentence(Lexicon& lexicon, const vector<string>& ws, int mx)
{

  Sentence sent ;
  int wc = 0 ;
  for (vector<string>::const_iterator i = ws.begin() ; i != ws.end() ; ++i) {
    sent.push_back(lexicon[*i]) ;
    ++ wc ;
  }
  for (int i = wc ; i != mx ; ++i) sent.push_back(0) ;

  //debug
  // for (Sentence::const_iterator i = sent.begin() ; i != sent.end() ; ++i)
  //  cout << *i << " " ; 
  cout << endl ;

  return sent ;
}

// render a sentence in words
void putSentence(const Wordlist& wlist, const Sentence sent)
{
  for (Sentence::const_iterator i = sent.begin() ; i != sent.end() ; ++i) {
    if (*i != 0) 
      cout << wlist[*i-1] << " " ;
  }
  cout << endl ;

}


// Haskell words
bool space(char c) 
{
  return isspace(c) ;
}
bool not_space(char c) 
{
  return !space(c) ;
}

vector<string> words(const string& s) 
{
  typedef string::const_iterator iter ;
  vector<string> ws ;
  iter i = s.begin() ;
  while (i != s.end()) {
    // ignore space
    i = find_if(i, s.end(), not_space) ;
    // collect characters until space
    iter j = find_if(i, s.end(), space) ;

    // add the string to the vector
    if (i != s.end())
      ws.push_back(string(i,j)) ;
    i = j ;
  }
  return ws ;
}


// the run-time grammar structure
struct Grammar {
  vector<string> langnames ;
  int nwords ;
  int nlangs ;
  int nsents ;
  int smaxlen ;
  Wordlist wlist ;
  Lexicon lexicon ;
  vector<Linearizer> lin ;
  vector<Parser> parser ;
} ;


// read grammar from file or stdio
Grammar readGrammar (istream& in)
{
  Grammar g ;

  in >> g.nwords >> g.nlangs >> g.nsents >> g.smaxlen ;

  string tok ;

  for (int ls = 0 ; ls != g.nlangs ; ++ls) {
    in >> tok ;
    g.langnames.push_back(tok) ;
  }

  for (int ls = 0 ; ls != g.nwords ; ++ls) {
    in >> tok ;
    g.lexicon[tok] = ls + 1 ;
    g.wlist.push_back(tok) ;
  }

  g.lin = vector<Linearizer>(g.nlangs) ;
  g.parser = vector<Parser>(g.nlangs) ;

  int w ;
  Sentence temp ;

  for (int ls = 0 ; ls != g.nlangs ; ++ls) {
    for (int ss = 0 ; ss != g.nsents ; ++ss) {
      temp = vector<int>() ;
      for (int ws = 0 ; ws != g.smaxlen ; ++ws) {

	in >> w ;
	temp.push_back(w) ; 
      } 

      g.lin[ls].push_back(temp) ;
      g.parser[ls][temp].push_back(ss) ;
    }
  }

  cout << "Grammar ready with languages " ;
  for (int i = 0 ; i != g.nlangs ; ++i) cout << g.langnames[i] << " " ;  
  cout << endl << endl ;

  return g ;
}

// translate string from any language to all other languages
void translate (Grammar& g, const string input)
{
  Sentence s ; // source

  s = getSentence(g.lexicon,words(input),g.smaxlen) ;

  Sentence t ; // target

  for (int k = 0 ; k != g.nlangs ; ++k) {
    if (!g.parser[k][s].empty()) {
      for (int m = 0 ; m != g.nlangs ; ++m) {
	if (m != k) cout << "** " << g.langnames[m] << ":" << endl ;
	for (vector<Tree>::const_iterator i = g.parser[k][s].begin() ; 
	     i != g.parser[k][s].end() ; ++i){
	  if (m != k) cout << "tree #" << *i << ": " ; // debug
	  if (m != k) putSentence (g.wlist, g.lin[m][*i]) ;
	}
      }
    }
  }
}

// balanced random generator
inline int nrand(int n)
{
  ///  if (n <= 0 || n > RAND_MAX)
  const int bucket_size = RAND_MAX / n ;
  int r ;

  // randomness from clock
  srand(time(NULL)) ;
  do r = (rand() + clock())/ bucket_size ;
  while (r >= n) ;

  return r ;

}

// generate random sentence and show it in all languages
void genRandom (const Grammar& g)
{
  Tree t = nrand(g.nsents) ;

  for (int k = 0 ; k != g.nlangs ; ++k) {
    cout << "** " << g.langnames[k] << ":" << endl ;
    putSentence (g.wlist, g.lin[k][t]) ;
  }
}

// quiz of ten translation examples
void quiz (Grammar& g, int src, int trg)
{
  int score = 0 ;

  for (int q = 0 ; q != 10 ; ++q) {
    Tree t = nrand(g.nsents) ;
    Sentence question = g.lin[src][t] ;
    putSentence (g.wlist, question) ;
    cout << "Translation:" << endl ;
    cout.flush() ;
    string answer ;
    ///    if (q == 0) {string foo ; cin >> foo ; cin.clear() ;}  ;
    getline (cin, answer) ;
    Sentence s = getSentence(g.lexicon,words(answer),g.smaxlen) ;

    bool result = false ;
    vector<Sentence> corrects ;
    for (vector<Tree>::const_iterator i = g.parser[src][question].begin() ; 
	 i != g.parser[src][question].end() ; ++i){
      if (equal(s.begin(), s.end(), g.lin[trg][*i].begin())){
	result = true ;
	break ;
      } else {
	corrects.push_back(g.lin[trg][*i]) ;
      }
    }
    if (result) {
      ++ score ;
      cout << "Correct." << endl ;
    } else {
      cout << "Incorrect. Correct answers are:" << endl ;
      for (int c = 0 ; c != corrects.size() ; ++c) 
	putSentence(g.wlist, corrects[c]) ;
    }
    cout << "Score: " << score << "/" << q+1 << endl << endl ;
  }
}

// generate all sentences in one language
void genAll(const Grammar& g, int lang)
{
  for (int i = 0 ; i != g.nsents ; ++i)
    putSentence(g.wlist, g.lin[lang][i]) ;
}

// translate language name to index in language vector
int getLang(const Grammar& g, const string lang)
{
  int res = 0 ;
  for (vector<string>::const_iterator i = g.langnames.begin() ;
       i != g.langnames.end() ; ++i)
    if (*i == lang)
      return res ;
    else
      ++res ;

}

void help ()
{
  cout << "Commands:" << endl ;
  cout << "  h                   print this help" << endl ;
  cout << "  .                   quit" << endl ;
  cout << "  !                   generate random example" << endl ;
  cout << "  ? <Lang1> <Lang2>   translation quiz from Lang1 to Lang2" << endl ;
  cout << "  * <Lang>            generate all sentences of Lang" << endl ;
  cout << "  <other sentence>    translate" << endl ;
  cout << endl ;
}

int main (int argc, char* argv[])
{

  if (argc != 2) {
    cout << "usage: gfex <grammarfile>" << endl ;
    return 1 ;
  }

  std::ifstream from(argv[1]) ;

  Grammar g = readGrammar (from) ;

  help() ;

  string input ;

  while (getline (cin,input)){

    if (input == ".") {
      cout << "bye" << endl ;
      return 0 ;
    }
    else if (input == "h")
      help() ;
    else if (input == "!")
      genRandom(g) ;
    else if (input[0] == '?') {
      string src = words(input)[1] ;
      string trg = words(input)[2] ;
      quiz(g,getLang(g,src), getLang(g,trg)) ;
    }
    else if (input[0] == '*') {
      string src = words(input)[1] ;
      genAll(g,getLang(g,src)) ;
    }
    else
      translate(g,input) ;

  cin.clear() ;

  //  cout << clock()/10000 ;

  cout << endl ;
  }

  return 0 ;
}

