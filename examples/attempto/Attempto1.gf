-- 15.58

abstract Attempto = {

flags startcat = ACEText ;

cat 
  ACEText ;
  Query ; 
  Command ;
fun 
  ASpecification : Specification -> ACEText ;
  AQuery : Query -> ACEText ;
  ACommand : Command -> ACEText ;
cat
  PropositionOrSentenceCoord ;
  TopicalisedQuestion ;
fun
  QQuery : PropositionOrSentenceCoord -> Query -> Query ;
  QTopicalizer : TopicalisedQuestion -> Query ;
cat
  ExistentialQuestionTopic ;
  SentenceCoord ;
fun
  TExistential : ExistentialQuestionTopic -> SentenceCoord -> TopicalisedQuestion ;
  TUniversal : UniversalTopic -> TopicalisedQuestion -> TopicalisedQuestion ;
  TQuestion : Question -> TopicalisedQuestion ;

}
