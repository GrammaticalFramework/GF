-- general grammar

abstract userCore = sharedCore ** {

cat
	-- A Dialogue Move that consists of a Request and arguments.
	CompoundedRequest;
	CompoundedAsk;
	AnswerList Task;


fun

	makeAnswerListS : (t : Task) -> AnswerList t -> DMove;

	makeCompoundedRequest : CompoundedRequest -> DMove;
	makeNegCompoundedRequest : CompoundedRequest -> DMove;
	makeCompoundedAsk : CompoundedAsk -> DMove;


	requestCompounded : (t : Task) -> Action t -> Answer t  -> CompoundedRequest ;
	requestCompoundedMulti : (t : Task) -> Action t -> AnswerList t -> CompoundedRequest;

	makeAskMove : (t : Task) -> Ask t -> Answer t -> CompoundedAsk;


}
