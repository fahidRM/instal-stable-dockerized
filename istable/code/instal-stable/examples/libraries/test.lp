%
% -------------------------------PART 1-------------------------------
%
%
% Standard prelude for pubA
%
% suppress clingo warnings in absence of inertials, non-inertials or obligations
ifluent(0,0).
nifluent(0,0).
oblfluent(0,0).
% fluent rules
holdsat(P,In,J):- holdsat(P,In,I),not terminated(P,In,I),
    next(I,J),ifluent(P, In),instant(I),instant(J), inst(In).
holdsat(P,In,J):- initiated(P,In,I),next(I,J),
    ifluent(P, In),instant(I),instant(J), inst(In).
holdsat(P,In,J):- initiated(P,In,I),next(I,J),
    oblfluent(P, In),instant(I),instant(J), inst(In).
% all observed events occur
occurred(E,In,I):- evtype(E,In,ex),observed(E,In,I),instant(I), inst(In).
% produces null for unknown events
occurred(null,In,I) :- not evtype(E,In,ex), observed(E,In,I),
    instant(I), inst(In).
% produces gap warning for unknown events
unknown(E, In, I) :- not evtype(E,In,ex), observed(E,In,I),
    instant(I), inst(In).
warninggap(In, I) :- unknown(E,In,I), inst(In), instant(I).
% a violation occurs for each non-permitted action
occurred(viol(E),In,I):-
    occurred(E,In,I),
    evtype(E,In,ex),
    not holdsat(perm(E),In,I),
    holdsat(live(In),In,I),evinst(E,In),
    event(E),instant(I),event(viol(E)),inst(In).
occurred(viol(E),In,I):-
    occurred(E,In,I),
    evtype(E,In,inst),
    not holdsat(perm(E),In,I),
    event(E),instant(I),event(viol(E)), inst(In).
% needed until I tidy up some of the constraint generation
% true.
start(0).
instant(0..T) :- final(T).
next(T,T+1) :- instant(T).
final(horizon).
% externals for individual institutions
% #external observed(E,I) : event(E), inst(I). removed 20160415 JAP
% observed(E,I,J) :- observed(E,I), start(J). removed 20160415 JAP
#external holdsat(F,I) : fluent(F,I), inst(I).
holdsat(F,I,J) :- holdsat(F,I), start(J).
#external holdsat(perm(E),I) : event(E), inst(I).
holdsat(perm(E),I,J) :- holdsat(perm(E),I), start(J).
#external holdsat(pow(E),I) : event(E), inst(I).
holdsat(pow(I,E),I,J) :- holdsat(pow(E),I), start(J).
% for incremental observations
#external observed(E) : event(E).
compObserved(E,J) :- observed(E), start(J).
% for observation sequences
#external observed(E,I) : event(E), instant(I).
compObserved(E,I) :- observed(E,I).

%
% Rules for Institution pubA
%
  ifluent(live(pubA), pubA).
  fluent(live(pubA), pubA).
  inst(pubA).
%
% Constraints for observable events
%
%%  mode COMPOSITE is chosen:
{compObserved(E, J)}:- evtype(E,In,ex),instant(J), not final(J), inst(In).
:- compObserved(E,J),compObserved(F,J),instant(J),evtype(E,InX,ex),
   evtype(F,InY,ex), E!=F,inst(InX;InY). 
obs(I):- compObserved(E,I),evtype(E,In,ex),instant(I),inst(In).
      :- not obs(I), not final(I), instant(I), inst(In).
observed(E,In,I) :- compObserved(E,I), inst(In), instant(I).
%
% Exogenous events
% Event: register (type: ex)
  event(register(User0)) :- user(User0).
  evtype(register(User0),pubA,ex) :- user(User0).
  evinst(register(User0),pubA) :- user(User0).
  ifluent(perm(register(User0)), pubA) :- user(User0).
  fluent(perm(register(User0)), pubA) :- user(User0).
  event(viol(register(User0))) :- user(User0).
  evtype(viol(register(User0)), pubA, viol) :- user(User0).
  evinst(viol(register(User0)),pubA) :- user(User0).
% Event: return (type: ex)
  event(return(User0,Book1)) :- user(User0),book(Book1).
  evtype(return(User0,Book1),pubA,ex) :- user(User0),book(Book1).
  evinst(return(User0,Book1),pubA) :- user(User0),book(Book1).
  ifluent(perm(return(User0,Book1)), pubA) :- user(User0),book(Book1).
  fluent(perm(return(User0,Book1)), pubA) :- user(User0),book(Book1).
  event(viol(return(User0,Book1))) :- user(User0),book(Book1).
  evtype(viol(return(User0,Book1)), pubA, viol) :- user(User0),book(Book1).
  evinst(viol(return(User0,Book1)),pubA) :- user(User0),book(Book1).
% Event: borrow (type: ex)
  event(borrow(User0,Book1)) :- user(User0),book(Book1).
  evtype(borrow(User0,Book1),pubA,ex) :- user(User0),book(Book1).
  evinst(borrow(User0,Book1),pubA) :- user(User0),book(Book1).
  ifluent(perm(borrow(User0,Book1)), pubA) :- user(User0),book(Book1).
  fluent(perm(borrow(User0,Book1)), pubA) :- user(User0),book(Book1).
  event(viol(borrow(User0,Book1))) :- user(User0),book(Book1).
  evtype(viol(borrow(User0,Book1)), pubA, viol) :- user(User0),book(Book1).
  evinst(viol(borrow(User0,Book1)),pubA) :- user(User0),book(Book1).
% Event: extend (type: ex)
  event(extend(User0)) :- user(User0).
  evtype(extend(User0),pubA,ex) :- user(User0).
  evinst(extend(User0),pubA) :- user(User0).
  ifluent(perm(extend(User0)), pubA) :- user(User0).
  fluent(perm(extend(User0)), pubA) :- user(User0).
  event(viol(extend(User0))) :- user(User0).
  evtype(viol(extend(User0)), pubA, viol) :- user(User0).
  evinst(viol(extend(User0)),pubA) :- user(User0).
%
% null event for unknown events
% Event: null (type: ex)
  event(null).
  evtype(null,pubA,ex).
  evinst(null,pubA).
  ifluent(perm(null), pubA).
  fluent(perm(null), pubA).
  event(viol(null)).
  evtype(viol(null),pubA,viol).
  evinst(viol(null),pubA).
% Institutional events
% Event: intReturn (type: in)
  event(intReturn(User0,Book1)) :- user(User0),book(Book1).
  evtype(intReturn(User0,Book1),pubA,inst) :- user(User0),book(Book1).
  evinst(intReturn(User0,Book1),pubA) :- user(User0),book(Book1).
  ifluent(pow(pubA,intReturn(User0,Book1)),pubA) :- user(User0),book(Book1).
  ifluent(perm(intReturn(User0,Book1)),pubA) :- user(User0),book(Book1).
  fluent(pow(pubA,intReturn(User0,Book1)),pubA) :- user(User0),book(Book1).
  fluent(perm(intReturn(User0,Book1)),pubA) :- user(User0),book(Book1).
  event(viol(intReturn(User0,Book1))) :- user(User0),book(Book1).
  evtype(viol(intReturn(User0,Book1)),pubA,viol) :- user(User0),book(Book1).
  evinst(viol(intReturn(User0,Book1)),pubA) :- user(User0),book(Book1).
% Event: due (type: in)
  event(due(User0,Book1)) :- user(User0),book(Book1).
  evtype(due(User0,Book1),pubA,inst) :- user(User0),book(Book1).
  evinst(due(User0,Book1),pubA) :- user(User0),book(Book1).
  ifluent(pow(pubA,due(User0,Book1)),pubA) :- user(User0),book(Book1).
  ifluent(perm(due(User0,Book1)),pubA) :- user(User0),book(Book1).
  fluent(pow(pubA,due(User0,Book1)),pubA) :- user(User0),book(Book1).
  fluent(perm(due(User0,Book1)),pubA) :- user(User0),book(Book1).
  event(viol(due(User0,Book1))) :- user(User0),book(Book1).
  evtype(viol(due(User0,Book1)),pubA,viol) :- user(User0),book(Book1).
  evinst(viol(due(User0,Book1)),pubA) :- user(User0),book(Book1).
% Event: intBorrow (type: in)
  event(intBorrow(User0,Book1)) :- user(User0),book(Book1).
  evtype(intBorrow(User0,Book1),pubA,inst) :- user(User0),book(Book1).
  evinst(intBorrow(User0,Book1),pubA) :- user(User0),book(Book1).
  ifluent(pow(pubA,intBorrow(User0,Book1)),pubA) :- user(User0),book(Book1).
  ifluent(perm(intBorrow(User0,Book1)),pubA) :- user(User0),book(Book1).
  fluent(pow(pubA,intBorrow(User0,Book1)),pubA) :- user(User0),book(Book1).
  fluent(perm(intBorrow(User0,Book1)),pubA) :- user(User0),book(Book1).
  event(viol(intBorrow(User0,Book1))) :- user(User0),book(Book1).
  evtype(viol(intBorrow(User0,Book1)),pubA,viol) :- user(User0),book(Book1).
  evinst(viol(intBorrow(User0,Book1)),pubA) :- user(User0),book(Book1).
% Event: intExtend (type: in)
  event(intExtend(User0)) :- user(User0).
  evtype(intExtend(User0),pubA,inst) :- user(User0).
  evinst(intExtend(User0),pubA) :- user(User0).
  ifluent(pow(pubA,intExtend(User0)),pubA) :- user(User0).
  ifluent(perm(intExtend(User0)),pubA) :- user(User0).
  fluent(pow(pubA,intExtend(User0)),pubA) :- user(User0).
  fluent(perm(intExtend(User0)),pubA) :- user(User0).
  event(viol(intExtend(User0))) :- user(User0).
  evtype(viol(intExtend(User0)),pubA,viol) :- user(User0).
  evinst(viol(intExtend(User0)),pubA) :- user(User0).
% Event: intRegister (type: in)
  event(intRegister(User0)) :- user(User0).
  evtype(intRegister(User0),pubA,inst) :- user(User0).
  evinst(intRegister(User0),pubA) :- user(User0).
  ifluent(pow(pubA,intRegister(User0)),pubA) :- user(User0).
  ifluent(perm(intRegister(User0)),pubA) :- user(User0).
  fluent(pow(pubA,intRegister(User0)),pubA) :- user(User0).
  fluent(perm(intRegister(User0)),pubA) :- user(User0).
  event(viol(intRegister(User0))) :- user(User0).
  evtype(viol(intRegister(User0)),pubA,viol) :- user(User0).
  evinst(viol(intRegister(User0)),pubA) :- user(User0).
%
% Violation events
%
% Event: issueFine (type: in)
  event(issueFine(User0,Book1)) :- user(User0),book(Book1).
  evtype(issueFine(User0,Book1),pubA,viol) :- user(User0),book(Book1).
  evinst(issueFine(User0,Book1),pubA) :- user(User0),book(Book1).
%
% Creation events
%
%
% Dissolution events
%
%
% dissolve events
%
%
% inertial fluents
%
ifluent(borrowed(User0,Book1),pubA) :-
  user(User0),book(Book1).
fluent(borrowed(User0,Book1),pubA) :-
  user(User0),book(Book1).

ifluent(inDebt(User0,Book1),pubA) :-
  user(User0),book(Book1).
fluent(inDebt(User0,Book1),pubA) :-
  user(User0),book(Book1).

ifluent(inCollection(Book0),pubA) :-
  book(Book0).
fluent(inCollection(Book0),pubA) :-
  book(Book0).

ifluent(onLoan(Book0),pubA) :-
  book(Book0).
fluent(onLoan(Book0),pubA) :-
  book(Book0).

ifluent(next(Number0,Number1),pubA) :-
  number(Number0),number(Number1).
fluent(next(Number0,Number1),pubA) :-
  number(Number0),number(Number1).

ifluent(allowance(User0,Number1),pubA) :-
  user(User0),number(Number1).
fluent(allowance(User0,Number1),pubA) :-
  user(User0),number(Number1).

ifluent(loans(User0,Number1),pubA) :-
  user(User0),number(Number1).
fluent(loans(User0,Number1),pubA) :-
  user(User0),number(Number1).

ifluent(registeredUser(User0),pubA) :-
  user(User0).
fluent(registeredUser(User0),pubA) :-
  user(User0).

%
% noninertial fluents
%
nifluent(available(Book0), pubA) :-
  book(Book0).
fluent(available(Book0), pubA) :-
  book(Book0).

nifluent(normalUser(User0), pubA) :-
  user(User0).
fluent(normalUser(User0), pubA) :-
  user(User0).

%
% violation fluents (to be implemented)

%
% obligation fluents
%
oblfluent(obl(intReturn(User0,Book1),due(User2,Book3),issueFine(User4,Book5)), pubA) :-
   event(intReturn(User0,Book1)),
   event(due(User2,Book3)),
   event(issueFine(User4,Book5)), user(User0),book(Book1),user(User2),book(Book3),user(User4),book(Book5),inst(pubA).
ifluent(obl(intReturn(User0,Book1),due(User2,Book3),issueFine(User4,Book5)), pubA) :-
   event(intReturn(User0,Book1)),
   event(due(User2,Book3)),
   event(issueFine(User4,Book5)), user(User0),book(Book1),user(User2),book(Book3),user(User4),book(Book5),inst(pubA).
fluent(obl(intReturn(User0,Book1),due(User2,Book3),issueFine(User4,Book5)), pubA) :-
   event(intReturn(User0,Book1)),
   event(due(User2,Book3)),
   event(issueFine(User4,Book5)), user(User0),book(Book1),user(User2),book(Book3),user(User4),book(Book5),inst(pubA).
terminated(obl(intReturn(User0,Book1),due(User2,Book3),issueFine(User4,Book5)),pubA,I) :-
   event(intReturn(User0,Book1)), occurred(intReturn(User0,Book1),pubA,I),
   event(due(User2,Book3)),
   holdsat(obl(intReturn(User0,Book1),due(User2,Book3),issueFine(User4,Book5)),pubA,I),
   event(issueFine(User4,Book5)), user(User0),book(Book1),user(User2),book(Book3),user(User4),book(Book5),inst(pubA).
terminated(obl(intReturn(User0,Book1),due(User2,Book3),issueFine(User4,Book5)),pubA,I) :-
   event(intReturn(User0,Book1)), 
   event(due(User2,Book3)), occurred(due(User2,Book3),pubA,I),
   holdsat(obl(intReturn(User0,Book1),due(User2,Book3),issueFine(User4,Book5)),pubA,I),
   event(issueFine(User4,Book5)), user(User0),book(Book1),user(User2),book(Book3),user(User4),book(Book5),inst(pubA).
occurred(issueFine(User4,Book5),pubA,I) :-
   event(intReturn(User0,Book1)), 
   event(due(User2,Book3)), occurred(due(User2,Book3),pubA,I),
   holdsat(obl(intReturn(User0,Book1),due(User2,Book3),issueFine(User4,Book5)),pubA,I),
   event(issueFine(User4,Book5)), user(User0),book(Book1),user(User2),book(Book3),user(User4),book(Book5),inst(pubA).
%
% -------------------------------PART 2-------------------------------
%
%
% generate rules
%
%
% Translation of intBorrow(User,Book) generates due(User,Book) if ['and', ['normalUser', ['User']], ['available', ['Book']]] in +3
occurred(due(User,Book),pubA,I+3) :- occurred(intBorrow(User,Book),pubA,I),
   holdsat(pow(pubA,due(User,Book)),pubA,I+3),
   holdsat(normalUser(User),pubA,I),
   holdsat(available(Book),pubA,I),
   book(Book),
   user(User),
   inst(pubA), instant(I).
%
% Translation of extend(User) generates intExtend(User) if ['registeredUser', ['User']] in 
occurred(intExtend(User),pubA,I) :- occurred(extend(User),pubA,I),
   holdsat(pow(pubA,intExtend(User)),pubA,I),
   holdsat(registeredUser(User),pubA,I),
   user(User),
   inst(pubA), instant(I).
%
% Translation of return(User,Book) generates intReturn(User,Book) if ['registeredUser', ['User']] in 
occurred(intReturn(User,Book),pubA,I) :- occurred(return(User,Book),pubA,I),
   holdsat(pow(pubA,intReturn(User,Book)),pubA,I),
   holdsat(registeredUser(User),pubA,I),
   book(Book),
   user(User),
   inst(pubA), instant(I).
%
% Translation of borrow(User,Book) generates intBorrow(User,Book) if ['registeredUser', ['User']] in 
occurred(intBorrow(User,Book),pubA,I) :- occurred(borrow(User,Book),pubA,I),
   holdsat(pow(pubA,intBorrow(User,Book)),pubA,I),
   holdsat(registeredUser(User),pubA,I),
   book(Book),
   user(User),
   inst(pubA), instant(I).
%
% Translation of register(User) generates intRegister(User) if [] in 
occurred(intRegister(User),pubA,I) :- occurred(register(User),pubA,I),
   holdsat(pow(pubA,intRegister(User)),pubA,I),
   user(User),
   inst(pubA), instant(I).
%
% initiate rules
%
%
% Translation of intExtend(User) initiates ['allowance', ['User', 'NewMax']] if ['and', ['allowance', ['User', 'Max']], ['next', ['Max', 'NewMax']]]
%
initiated(allowance(User,NewMax),pubA,I) :-
   occurred(intExtend(User),pubA,I),
   holdsat(live(pubA),pubA,I), inst(pubA),
   holdsat(allowance(User,Max),pubA,I),
   holdsat(next(Max,NewMax),pubA,I),
   number(Max),
   user(User),
   number(NewMax),
   inst(pubA), instant(I).
%
% Translation of issueFine(User,Book) initiates ['inDebt', ['User', 'Book']] if []
%
initiated(inDebt(User,Book),pubA,I) :-
   occurred(issueFine(User,Book),pubA,I),
   holdsat(live(pubA),pubA,I), inst(pubA),
   book(Book),
   user(User),
   inst(pubA), instant(I).
%
% Translation of intReturn(User,Book) initiates ['loans', ['User', 'NewNumber']] if ['and', ['loans', ['User', 'Number']], ['next', ['NewNumber', 'Number']]]
%
initiated(loans(User,NewNumber),pubA,I) :-
   occurred(intReturn(User,Book),pubA,I),
   holdsat(live(pubA),pubA,I), inst(pubA),
   holdsat(loans(User,Number),pubA,I),
   holdsat(next(NewNumber,Number),pubA,I),
   number(NewNumber),
   book(Book),
   user(User),
   number(Number),
   inst(pubA), instant(I).
%
% Translation of intBorrow(User,Book) initiates ['perm', ['return', ['User', 'Book']]] if ['and', ['normalUser', ['User']], ['available', ['Book']]]
%
initiated(perm(return(User,Book)),pubA,I) :-
   occurred(intBorrow(User,Book),pubA,I),
   holdsat(live(pubA),pubA,I), inst(pubA),
   holdsat(normalUser(User),pubA,I),
   holdsat(available(Book),pubA,I),
   book(Book),
   user(User),
   inst(pubA), instant(I).
%
% Translation of intBorrow(User,Book) initiates ['perm', ['intReturn', ['User', 'Book']]] if ['and', ['normalUser', ['User']], ['available', ['Book']]]
%
initiated(perm(intReturn(User,Book)),pubA,I) :-
   occurred(intBorrow(User,Book),pubA,I),
   holdsat(live(pubA),pubA,I), inst(pubA),
   holdsat(normalUser(User),pubA,I),
   holdsat(available(Book),pubA,I),
   book(Book),
   user(User),
   inst(pubA), instant(I).
%
% Translation of intBorrow(User,Book) initiates ['pow', ['intReturn', ['User', 'Book']]] if ['and', ['normalUser', ['User']], ['available', ['Book']]]
%
initiated(pow(pubA,intReturn(User,Book)),pubA,I) :-
   occurred(intBorrow(User,Book),pubA,I),
   holdsat(live(pubA),pubA,I), inst(pubA),
   holdsat(normalUser(User),pubA,I),
   holdsat(available(Book),pubA,I),
   book(Book),
   user(User),
   inst(pubA), instant(I).
%
% Translation of intBorrow(User,Book) initiates ['borrowed', ['User', 'Book']] if ['and', ['and', ['and', ['normalUser', ['User']], ['available', ['Book']]], ['loans', ['User', 'Number']]], ['next', ['Number', 'NewNumber']]]
%
initiated(borrowed(User,Book),pubA,I) :-
   occurred(intBorrow(User,Book),pubA,I),
   holdsat(live(pubA),pubA,I), inst(pubA),
   holdsat(normalUser(User),pubA,I),
   holdsat(available(Book),pubA,I),
   holdsat(loans(User,Number),pubA,I),
   holdsat(next(Number,NewNumber),pubA,I),
   number(NewNumber),
   book(Book),
   user(User),
   number(Number),
   inst(pubA), instant(I).
%
% Translation of intBorrow(User,Book) initiates ['onLoan', ['Book']] if ['and', ['and', ['and', ['normalUser', ['User']], ['available', ['Book']]], ['loans', ['User', 'Number']]], ['next', ['Number', 'NewNumber']]]
%
initiated(onLoan(Book),pubA,I) :-
   occurred(intBorrow(User,Book),pubA,I),
   holdsat(live(pubA),pubA,I), inst(pubA),
   holdsat(normalUser(User),pubA,I),
   holdsat(available(Book),pubA,I),
   holdsat(loans(User,Number),pubA,I),
   holdsat(next(Number,NewNumber),pubA,I),
   number(NewNumber),
   book(Book),
   user(User),
   number(Number),
   inst(pubA), instant(I).
%
% Translation of intBorrow(User,Book) initiates ['loans', ['User', 'NewNumber']] if ['and', ['and', ['and', ['normalUser', ['User']], ['available', ['Book']]], ['loans', ['User', 'Number']]], ['next', ['Number', 'NewNumber']]]
%
initiated(loans(User,NewNumber),pubA,I) :-
   occurred(intBorrow(User,Book),pubA,I),
   holdsat(live(pubA),pubA,I), inst(pubA),
   holdsat(normalUser(User),pubA,I),
   holdsat(available(Book),pubA,I),
   holdsat(loans(User,Number),pubA,I),
   holdsat(next(Number,NewNumber),pubA,I),
   number(NewNumber),
   book(Book),
   user(User),
   number(Number),
   inst(pubA), instant(I).
%
% Translation of intBorrow(User,Book) initiates ['obl', [['intReturn', ['User', 'Book']], ['due', ['User', 'Book']], ['issueFine', ['User', 'Book']]]] if ['and', ['and', ['and', ['normalUser', ['User']], ['available', ['Book']]], ['loans', ['User', 'Number']]], ['next', ['Number', 'NewNumber']]]
%
initiated(obl(intReturn(User,Book),due(User,Book),issueFine(User,Book)),pubA,I) :-
   occurred(intBorrow(User,Book),pubA,I),
   holdsat(live(pubA),pubA,I), inst(pubA),
   holdsat(normalUser(User),pubA,I),
   holdsat(available(Book),pubA,I),
   holdsat(loans(User,Number),pubA,I),
   holdsat(next(Number,NewNumber),pubA,I),
   number(NewNumber),
   book(Book),
   user(User),
   number(Number),
   inst(pubA), instant(I).
%
% Translation of intRegister(User) initiates ['perm', ['extend', ['User']]] if []
%
initiated(perm(extend(User)),pubA,I) :-
   occurred(intRegister(User),pubA,I),
   holdsat(live(pubA),pubA,I), inst(pubA),
   user(User),
   inst(pubA), instant(I).
%
% Translation of intRegister(User) initiates ['perm', ['intExtend', ['User']]] if []
%
initiated(perm(intExtend(User)),pubA,I) :-
   occurred(intRegister(User),pubA,I),
   holdsat(live(pubA),pubA,I), inst(pubA),
   user(User),
   inst(pubA), instant(I).
%
% Translation of intRegister(User) initiates ['pow', ['intExtend', ['User']]] if []
%
initiated(pow(pubA,intExtend(User)),pubA,I) :-
   occurred(intRegister(User),pubA,I),
   holdsat(live(pubA),pubA,I), inst(pubA),
   user(User),
   inst(pubA), instant(I).
%
% Translation of intRegister(User) initiates ['perm', ['borrow', ['User', 'Book']]] if []
%
initiated(perm(borrow(User,Book)),pubA,I) :-
   occurred(intRegister(User),pubA,I),
   holdsat(live(pubA),pubA,I), inst(pubA),
   user(User),
   book(Book),
   inst(pubA), instant(I).
%
% Translation of intRegister(User) initiates ['perm', ['intBorrow', ['User', 'Book']]] if []
%
initiated(perm(intBorrow(User,Book)),pubA,I) :-
   occurred(intRegister(User),pubA,I),
   holdsat(live(pubA),pubA,I), inst(pubA),
   user(User),
   book(Book),
   inst(pubA), instant(I).
%
% Translation of intRegister(User) initiates ['pow', ['intBorrow', ['User', 'Book']]] if []
%
initiated(pow(pubA,intBorrow(User,Book)),pubA,I) :-
   occurred(intRegister(User),pubA,I),
   holdsat(live(pubA),pubA,I), inst(pubA),
   user(User),
   book(Book),
   inst(pubA), instant(I).
%
% Translation of intRegister(User) initiates ['registeredUser', ['User']] if []
%
initiated(registeredUser(User),pubA,I) :-
   occurred(intRegister(User),pubA,I),
   holdsat(live(pubA),pubA,I), inst(pubA),
   user(User),
   inst(pubA), instant(I).
%
% Translation of intRegister(User) initiates ['allowance', ['User', '2']] if []
%
initiated(allowance(User,2),pubA,I) :-
   occurred(intRegister(User),pubA,I),
   holdsat(live(pubA),pubA,I), inst(pubA),
   user(User),
   inst(pubA), instant(I).
%
% Translation of intRegister(User) initiates ['loans', ['User', '0']] if []
%
initiated(loans(User,0),pubA,I) :-
   occurred(intRegister(User),pubA,I),
   holdsat(live(pubA),pubA,I), inst(pubA),
   user(User),
   inst(pubA), instant(I).
%
% terminate rules
%
%
% Translation of intExtend(User) terminates ['allowance', ['User', 'Max']] if ['allowance', ['User', 'Max']]
%
terminated(allowance(User,Max),pubA,I) :-
   occurred(intExtend(User),pubA,I),
   holdsat(live(pubA),pubA,I),inst(pubA),
   holdsat(allowance(User,Max),pubA,I),
   number(Max),
   user(User),
   inst(pubA), instant(I).
%
% Translation of intReturn(User,Book) terminates ['onLoan', ['Book']] if ['loans', ['User', 'Number']]
%
terminated(onLoan(Book),pubA,I) :-
   occurred(intReturn(User,Book),pubA,I),
   holdsat(live(pubA),pubA,I),inst(pubA),
   holdsat(loans(User,Number),pubA,I),
   book(Book),
   user(User),
   number(Number),
   inst(pubA), instant(I).
%
% Translation of intReturn(User,Book) terminates ['borrowed', ['User', 'Book']] if ['loans', ['User', 'Number']]
%
terminated(borrowed(User,Book),pubA,I) :-
   occurred(intReturn(User,Book),pubA,I),
   holdsat(live(pubA),pubA,I),inst(pubA),
   holdsat(loans(User,Number),pubA,I),
   book(Book),
   user(User),
   number(Number),
   inst(pubA), instant(I).
%
% Translation of intReturn(User,Book) terminates ['loans', ['User', 'Number']] if ['loans', ['User', 'Number']]
%
terminated(loans(User,Number),pubA,I) :-
   occurred(intReturn(User,Book),pubA,I),
   holdsat(live(pubA),pubA,I),inst(pubA),
   holdsat(loans(User,Number),pubA,I),
   book(Book),
   user(User),
   number(Number),
   inst(pubA), instant(I).
%
% Translation of intBorrow(User,Book) terminates ['loans', ['User', 'Number']] if ['and', ['and', ['normalUser', ['User']], ['available', ['Book']]], ['loans', ['User', 'Number']]]
%
terminated(loans(User,Number),pubA,I) :-
   occurred(intBorrow(User,Book),pubA,I),
   holdsat(live(pubA),pubA,I),inst(pubA),
   holdsat(normalUser(User),pubA,I),
   holdsat(available(Book),pubA,I),
   holdsat(loans(User,Number),pubA,I),
   book(Book),
   user(User),
   number(Number),
   inst(pubA), instant(I).
%
% noninertial rules
%
%
% Translation of available(Book) when ['and', ['inCollection', ['Book']], ['not', ['onLoan', ['Book']]]]
holdsat(available(Book),pubA,I) :-
   holdsat(inCollection(Book),pubA,I),
   not
   holdsat(onLoan(Book),pubA,I),
   book(Book),
   inst(pubA), instant(I).
%
% Translation of normalUser(User) when ['and', ['and', ['and', ['registeredUser', ['User']], ['allowance', ['User', 'Max']]], ['loans', ['User', 'Number']]], ['<', ['Number', 'Max']]]
holdsat(normalUser(User),pubA,I) :-
   holdsat(registeredUser(User),pubA,I),
   holdsat(allowance(User,Max),pubA,I),
   holdsat(loans(User,Number),pubA,I),
   Number<Max,
   number(Max),
   user(User),
   number(Number),
   inst(pubA), instant(I).
%
% -------------------------------PART 3-------------------------------
%
%
% initially
%
% no creation event
holdsat(live(pubA),pubA,I) :- start(I), inst(pubA).
holdsat(perm(null),pubA,I) :- start(I), inst(pubA).
% initially: perm(register(User))
holdsat(perm(register(User)),pubA,I) :-
   user(User),
   inst(pubA), start(I).
% initially: perm(intRegister(User))
holdsat(perm(intRegister(User)),pubA,I) :-
   user(User),
   inst(pubA), start(I).
% initially: pow(pubA,intRegister(User))
holdsat(pow(pubA,intRegister(User)),pubA,I) :-
   user(User),
   inst(pubA), start(I).
% initially: perm(due(User,Book))
holdsat(perm(due(User,Book)),pubA,I) :-
   book(Book),
   user(User),
   inst(pubA), start(I).
% initially: pow(pubA,due(User,Book))
holdsat(pow(pubA,due(User,Book)),pubA,I) :-
   book(Book),
   user(User),
   inst(pubA), start(I).
% initially: inCollection(book1_a)
holdsat(inCollection(book1_a),pubA,I) :-
   inst(pubA), start(I).
% initially: inCollection(book2_a)
holdsat(inCollection(book2_a),pubA,I) :-
   inst(pubA), start(I).
% initially: inCollection(book3_a)
holdsat(inCollection(book3_a),pubA,I) :-
   inst(pubA), start(I).
% initially: inCollection(book4_a)
holdsat(inCollection(book4_a),pubA,I) :-
   inst(pubA), start(I).
% initially: next(0,1)
holdsat(next(0,1),pubA,I) :-
   inst(pubA), start(I).
% initially: next(1,2)
holdsat(next(1,2),pubA,I) :-
   inst(pubA), start(I).
% initially: next(2,3)
holdsat(next(2,3),pubA,I) :-
   inst(pubA), start(I).
% initially: next(3,4)
holdsat(next(3,4),pubA,I) :-
   inst(pubA), start(I).
% initially: next(4,5)
holdsat(next(4,5),pubA,I) :-
   inst(pubA), start(I).
%
% -------------------------------GROUNDING-------------------------------
%
% Book
#program book(l).
book(l).

% User
#program user(l).
user(l).

% Number
#program number(l).
number(l).

%
% End of file
%
