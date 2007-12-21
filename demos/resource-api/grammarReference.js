// Grammar Reference
function concreteReference(concreteSyntax, concreteSyntaxName) {
this.concreteSyntax = concreteSyntax;
this.concreteSyntaxName = concreteSyntaxName;
}
var myAbstract = OverLang ;
var myConcrete = new Array();
myConcrete.push(new concreteReference(OverLangEng,"OverLangEng"));
myConcrete.push(new concreteReference(OverLangRus,"OverLangRus"));
myConcrete.push(new concreteReference(OverLangSwe,"OverLangSwe"));
