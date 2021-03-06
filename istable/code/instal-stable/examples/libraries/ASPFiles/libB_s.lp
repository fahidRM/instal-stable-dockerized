%
% Domain declarations for libB
%
user(alice).
user(bob).
book(book1_a).
book(book2_a).
book(book3_a).
book(book4_a).
book(book1_b).
book(book2_b).
book(book1_c).
book(book2_c).
number(0).
number(1).
number(2).
number(3).
number(4).
number(5).
%
% -------------------------------PART 1-------------------------------
%
%
% Standard prelude for libB
%
% instant ordering
% removed for MDV 20130117
%%% before(I1,I2):- next(I1,I2),instant(I1), instant(I2).
%%% before(I1,I3):- before(I1,I2),before(I2,I3),
%%%    instant(I1),instant(I2),instant(I3).
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
true.
%
% Rules for Institution libB
%
  ifluent(live(libB), libB).
  fluent(live(libB), libB).
  inst(libB).
%
% Constraints for obserable events depending on mode option
%
%%  mode SINGLE is chosen:
{observed(E,In,J)}:- evtype(E,In,ex),instant(J), not final(J), inst(In).
:- observed(E,In,J),observed(F,In,J),instant(J),evtype(E,In,ex),
evtype(F,In,ex), E!=F,inst(In). 
obs(In,I):- observed(E,In,I),evtype(E,In,ex),instant(I),inst(In).
         :- not obs(In,I), not final(I), instant(I), inst(In).

%
% The following types were declared:
%
% Book
% User
% Number
%
% Exogenous events
% Event: extRegister (type: ex)
  event(extRegister(User0)) :- user(User0).
  evtype(extRegister(User0),libB,ex) :- user(User0).
  evinst(extRegister(User0),libB) :- user(User0).
  ifluent(perm(extRegister(User0)), libB) :- user(User0).
  fluent(perm(extRegister(User0)), libB) :- user(User0).
  event(viol(extRegister(User0))) :- user(User0).
  evtype(viol(extRegister(User0)), libB, viol) :- user(User0).
  evinst(viol(extRegister(User0)),libB) :- user(User0).
% Event: extBorrow (type: ex)
  event(extBorrow(User0,Book1)) :- user(User0),book(Book1).
  evtype(extBorrow(User0,Book1),libB,ex) :- user(User0),book(Book1).
  evinst(extBorrow(User0,Book1),libB) :- user(User0),book(Book1).
  ifluent(perm(extBorrow(User0,Book1)), libB) :- user(User0),book(Book1).
  fluent(perm(extBorrow(User0,Book1)), libB) :- user(User0),book(Book1).
  event(viol(extBorrow(User0,Book1))) :- user(User0),book(Book1).
  evtype(viol(extBorrow(User0,Book1)), libB, viol) :- user(User0),book(Book1).
  evinst(viol(extBorrow(User0,Book1)),libB) :- user(User0),book(Book1).
% Event: register (type: ex)
  event(register(User0)) :- user(User0).
  evtype(register(User0),libB,ex) :- user(User0).
  evinst(register(User0),libB) :- user(User0).
  ifluent(perm(register(User0)), libB) :- user(User0).
  fluent(perm(register(User0)), libB) :- user(User0).
  event(viol(register(User0))) :- user(User0).
  evtype(viol(register(User0)), libB, viol) :- user(User0).
  evinst(viol(register(User0)),libB) :- user(User0).
% Event: return (type: ex)
  event(return(User0,Book1)) :- user(User0),book(Book1).
  evtype(return(User0,Book1),libB,ex) :- user(User0),book(Book1).
  evinst(return(User0,Book1),libB) :- user(User0),book(Book1).
  ifluent(perm(return(User0,Book1)), libB) :- user(User0),book(Book1).
  fluent(perm(return(User0,Book1)), libB) :- user(User0),book(Book1).
  event(viol(return(User0,Book1))) :- user(User0),book(Book1).
  evtype(viol(return(User0,Book1)), libB, viol) :- user(User0),book(Book1).
  evinst(viol(return(User0,Book1)),libB) :- user(User0),book(Book1).
% Event: borrow (type: ex)
  event(borrow(User0,Book1)) :- user(User0),book(Book1).
  evtype(borrow(User0,Book1),libB,ex) :- user(User0),book(Book1).
  evinst(borrow(User0,Book1),libB) :- user(User0),book(Book1).
  ifluent(perm(borrow(User0,Book1)), libB) :- user(User0),book(Book1).
  fluent(perm(borrow(User0,Book1)), libB) :- user(User0),book(Book1).
  event(viol(borrow(User0,Book1))) :- user(User0),book(Book1).
  evtype(viol(borrow(User0,Book1)), libB, viol) :- user(User0),book(Book1).
  evinst(viol(borrow(User0,Book1)),libB) :- user(User0),book(Book1).
%
% null event for unknown events
% Event: null (type: ex)
  event(null).
  evtype(null,libB,ex).
  evinst(null,libB).
  ifluent(perm(null), libB).
  fluent(perm(null), libB).
  event(viol(null)).
  evtype(viol(null),libB,viol).
  evinst(viol(null),libB).
% Institutional events
% Event: intReturn (type: in)
  event(intReturn(User0,Book1)) :- user(User0),book(Book1).
  evtype(intReturn(User0,Book1),libB,inst) :- user(User0),book(Book1).
  evinst(intReturn(User0,Book1),libB) :- user(User0),book(Book1).
  ifluent(pow(libB,intReturn(User0,Book1)),libB) :- user(User0),book(Book1).
  ifluent(perm(intReturn(User0,Book1)),libB) :- user(User0),book(Book1).
  fluent(pow(libB,intReturn(User0,Book1)),libB) :- user(User0),book(Book1).
  fluent(perm(intReturn(User0,Book1)),libB) :- user(User0),book(Book1).
  event(viol(intReturn(User0,Book1))) :- user(User0),book(Book1).
  evtype(viol(intReturn(User0,Book1)),libB,viol) :- user(User0),book(Book1).
  evinst(viol(intReturn(User0,Book1)),libB) :- user(User0),book(Book1).
% Event: intBorrow (type: in)
  event(intBorrow(User0,Book1)) :- user(User0),book(Book1).
  evtype(intBorrow(User0,Book1),libB,inst) :- user(User0),book(Book1).
  evinst(intBorrow(User0,Book1),libB) :- user(User0),book(Book1).
  ifluent(pow(libB,intBorrow(User0,Book1)),libB) :- user(User0),book(Book1).
  ifluent(perm(intBorrow(User0,Book1)),libB) :- user(User0),book(Book1).
  fluent(pow(libB,intBorrow(User0,Book1)),libB) :- user(User0),book(Book1).
  fluent(perm(intBorrow(User0,Book1)),libB) :- user(User0),book(Book1).
  event(viol(intBorrow(User0,Book1))) :- user(User0),book(Book1).
  evtype(viol(intBorrow(User0,Book1)),libB,viol) :- user(User0),book(Book1).
  evinst(viol(intBorrow(User0,Book1)),libB) :- user(User0),book(Book1).
% Event: due (type: in)
  event(due(User0,Book1)) :- user(User0),book(Book1).
  evtype(due(User0,Book1),libB,inst) :- user(User0),book(Book1).
  evinst(due(User0,Book1),libB) :- user(User0),book(Book1).
  ifluent(pow(libB,due(User0,Book1)),libB) :- user(User0),book(Book1).
  ifluent(perm(due(User0,Book1)),libB) :- user(User0),book(Book1).
  fluent(pow(libB,due(User0,Book1)),libB) :- user(User0),book(Book1).
  fluent(perm(due(User0,Book1)),libB) :- user(User0),book(Book1).
  event(viol(due(User0,Book1))) :- user(User0),book(Book1).
  evtype(viol(due(User0,Book1)),libB,viol) :- user(User0),book(Book1).
  evinst(viol(due(User0,Book1)),libB) :- user(User0),book(Book1).
% Event: intRegister (type: in)
  event(intRegister(User0)) :- user(User0).
  evtype(intRegister(User0),libB,inst) :- user(User0).
  evinst(intRegister(User0),libB) :- user(User0).
  ifluent(pow(libB,intRegister(User0)),libB) :- user(User0).
  ifluent(perm(intRegister(User0)),libB) :- user(User0).
  fluent(pow(libB,intRegister(User0)),libB) :- user(User0).
  fluent(perm(intRegister(User0)),libB) :- user(User0).
  event(viol(intRegister(User0))) :- user(User0).
  evtype(viol(intRegister(User0)),libB,viol) :- user(User0).
  evinst(viol(intRegister(User0)),libB) :- user(User0).
% Event: intExtRegister (type: in)
  event(intExtRegister(User0)) :- user(User0).
  evtype(intExtRegister(User0),libB,inst) :- user(User0).
  evinst(intExtRegister(User0),libB) :- user(User0).
  ifluent(pow(libB,intExtRegister(User0)),libB) :- user(User0).
  ifluent(perm(intExtRegister(User0)),libB) :- user(User0).
  fluent(pow(libB,intExtRegister(User0)),libB) :- user(User0).
  fluent(perm(intExtRegister(User0)),libB) :- user(User0).
  event(viol(intExtRegister(User0))) :- user(User0).
  evtype(viol(intExtRegister(User0)),libB,viol) :- user(User0).
  evinst(viol(intExtRegister(User0)),libB) :- user(User0).
% Event: intExtBorrow (type: in)
  event(intExtBorrow(User0,Book1)) :- user(User0),book(Book1).
  evtype(intExtBorrow(User0,Book1),libB,inst) :- user(User0),book(Book1).
  evinst(intExtBorrow(User0,Book1),libB) :- user(User0),book(Book1).
  ifluent(pow(libB,intExtBorrow(User0,Book1)),libB) :- user(User0),book(Book1).
  ifluent(perm(intExtBorrow(User0,Book1)),libB) :- user(User0),book(Book1).
  fluent(pow(libB,intExtBorrow(User0,Book1)),libB) :- user(User0),book(Book1).
  fluent(perm(intExtBorrow(User0,Book1)),libB) :- user(User0),book(Book1).
  event(viol(intExtBorrow(User0,Book1))) :- user(User0),book(Book1).
  evtype(viol(intExtBorrow(User0,Book1)),libB,viol) :- user(User0),book(Book1).
  evinst(viol(intExtBorrow(User0,Book1)),libB) :- user(User0),book(Book1).
%
% Violation events
%
% Event: issueFine (type: in)
  event(issueFine(User0,Book1)) :- user(User0),book(Book1).
  evtype(issueFine(User0,Book1),libB,viol) :- user(User0),book(Book1).
  evinst(issueFine(User0,Book1),libB) :- user(User0),book(Book1).
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
ifluent(borrowed(User0,Book1),libB) :-
  user(User0),book(Book1).
fluent(borrowed(User0,Book1),libB) :-
  user(User0),book(Book1).

ifluent(inDebt(User0,Book1),libB) :-
  user(User0),book(Book1).
fluent(inDebt(User0,Book1),libB) :-
  user(User0),book(Book1).

ifluent(inCollection(Book0),libB) :-
  book(Book0).
fluent(inCollection(Book0),libB) :-
  book(Book0).

ifluent(onLoan(Book0),libB) :-
  book(Book0).
fluent(onLoan(Book0),libB) :-
  book(Book0).

ifluent(next(Number0,Number1),libB) :-
  number(Number0),number(Number1).
fluent(next(Number0,Number1),libB) :-
  number(Number0),number(Number1).

ifluent(member(User0),libB) :-
  user(User0).
fluent(member(User0),libB) :-
  user(User0).

ifluent(allowance(User0,Number1),libB) :-
  user(User0),number(Number1).
fluent(allowance(User0,Number1),libB) :-
  user(User0),number(Number1).

ifluent(loans(User0,Number1),libB) :-
  user(User0),number(Number1).
fluent(loans(User0,Number1),libB) :-
  user(User0),number(Number1).

ifluent(registeredUser(User0),libB) :-
  user(User0).
fluent(registeredUser(User0),libB) :-
  user(User0).

%
% noninertial fluents
%
nifluent(available(Book0), libB) :-
  book(Book0).
fluent(available(Book0), libB) :-
  book(Book0).

nifluent(normalUser(User0), libB) :-
  user(User0).
fluent(normalUser(User0), libB) :-
  user(User0).

%
% violation fluents (to be implemented)

%
% obligation fluents
%
oblfluent(obl(intReturn(User0,Book1),due(User2,Book3),issueFine(User4,Book5)), libB) :-
   event(intReturn(User0,Book1)),
   event(due(User2,Book3)),
   event(issueFine(User4,Book5)), user(User0),book(Book1),user(User2),book(Book3),user(User4),book(Book5),inst(libB).
ifluent(obl(intReturn(User0,Book1),due(User2,Book3),issueFine(User4,Book5)), libB) :-
   event(intReturn(User0,Book1)),
   event(due(User2,Book3)),
   event(issueFine(User4,Book5)), user(User0),book(Book1),user(User2),book(Book3),user(User4),book(Book5),inst(libB).
fluent(obl(intReturn(User0,Book1),due(User2,Book3),issueFine(User4,Book5)), libB) :-
   event(intReturn(User0,Book1)),
   event(due(User2,Book3)),
   event(issueFine(User4,Book5)), user(User0),book(Book1),user(User2),book(Book3),user(User4),book(Book5),inst(libB).
terminated(obl(intReturn(User0,Book1),due(User2,Book3),issueFine(User4,Book5)),libB,I) :-
   event(intReturn(User0,Book1)), occurred(intReturn(User0,Book1),libB,I),
   event(due(User2,Book3)),
   holdsat(obl(intReturn(User0,Book1),due(User2,Book3),issueFine(User4,Book5)),libB,I),
   event(issueFine(User4,Book5)), user(User0),book(Book1),user(User2),book(Book3),user(User4),book(Book5),inst(libB).
terminated(obl(intReturn(User0,Book1),due(User2,Book3),issueFine(User4,Book5)),libB,I) :-
   event(intReturn(User0,Book1)), 
   event(due(User2,Book3)), occurred(due(User2,Book3),libB,I),
   holdsat(obl(intReturn(User0,Book1),due(User2,Book3),issueFine(User4,Book5)),libB,I),
   event(issueFine(User4,Book5)), user(User0),book(Book1),user(User2),book(Book3),user(User4),book(Book5),inst(libB).
occurred(issueFine(User4,Book5),libB,I) :-
   event(intReturn(User0,Book1)), 
   event(due(User2,Book3)), occurred(due(User2,Book3),libB,I),
   holdsat(obl(intReturn(User0,Book1),due(User2,Book3),issueFine(User4,Book5)),libB,I),
   event(issueFine(User4,Book5)), user(User0),book(Book1),user(User2),book(Book3),user(User4),book(Book5),inst(libB).
%
% -------------------------------PART 2-------------------------------
%
%
% generate rules
%
%
% Translation of extBorrow(User,Book) generates intBorrow(User,Book) if ['and', ['registeredUser', ['User']], ['not', ['member', ['User']]]] in 
occurred(intBorrow(User,Book),libB,I) :- occurred(extBorrow(User,Book),libB,I),
   holdsat(pow(libB,intBorrow(User,Book)),libB,I),
   holdsat(registeredUser(User),libB,I),
   not
   holdsat(member(User),libB,I),
   book(Book),
   user(User),
   inst(libB), instant(I).
%
% Translation of extRegister(User) generates intExtRegister(User) if [] in 
occurred(intExtRegister(User),libB,I) :- occurred(extRegister(User),libB,I),
   holdsat(pow(libB,intExtRegister(User)),libB,I),
   user(User),
   inst(libB), instant(I).
%
% Translation of intBorrow(User,Book) generates due(User,Book) if ['and', ['normalUser', ['User']], ['available', ['Book']]] in +3
occurred(due(User,Book),libB,I+3) :- occurred(intBorrow(User,Book),libB,I),
   holdsat(pow(libB,due(User,Book)),libB,I+3),
   holdsat(normalUser(User),libB,I),
   holdsat(available(Book),libB,I),
   book(Book),
   user(User),
   inst(libB), instant(I).
%
% Translation of return(User,Book) generates intReturn(User,Book) if ['registeredUser', ['User']] in 
occurred(intReturn(User,Book),libB,I) :- occurred(return(User,Book),libB,I),
   holdsat(pow(libB,intReturn(User,Book)),libB,I),
   holdsat(registeredUser(User),libB,I),
   book(Book),
   user(User),
   inst(libB), instant(I).
%
% Translation of borrow(User,Book) generates intBorrow(User,Book) if ['and', ['registeredUser', ['User']], ['member', ['User']]] in 
occurred(intBorrow(User,Book),libB,I) :- occurred(borrow(User,Book),libB,I),
   holdsat(pow(libB,intBorrow(User,Book)),libB,I),
   holdsat(registeredUser(User),libB,I),
   holdsat(member(User),libB,I),
   book(Book),
   user(User),
   inst(libB), instant(I).
%
% Translation of register(User) generates intRegister(User) if ['member', ['User']] in 
occurred(intRegister(User),libB,I) :- occurred(register(User),libB,I),
   holdsat(pow(libB,intRegister(User)),libB,I),
   holdsat(member(User),libB,I),
   user(User),
   inst(libB), instant(I).
%
% initiate rules
%
%
% Translation of issueFine(User,Book) initiates ['inDebt', ['User', 'Book']] if []
%
initiated(inDebt(User,Book),libB,I) :-
   occurred(issueFine(User,Book),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   book(Book),
   user(User),
   inst(libB), instant(I).
%
% Translation of intReturn(User,Book) initiates ['loans', ['User', 'NewNumber']] if ['and', ['loans', ['User', 'Number']], ['next', ['NewNumber', 'Number']]]
%
initiated(loans(User,NewNumber),libB,I) :-
   occurred(intReturn(User,Book),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   holdsat(loans(User,Number),libB,I),
   holdsat(next(NewNumber,Number),libB,I),
   number(NewNumber),
   book(Book),
   user(User),
   number(Number),
   inst(libB), instant(I).
%
% Translation of intBorrow(User,Book) initiates ['perm', ['return', ['User', 'Book']]] if ['and', ['normalUser', ['User']], ['available', ['Book']]]
%
initiated(perm(return(User,Book)),libB,I) :-
   occurred(intBorrow(User,Book),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   holdsat(normalUser(User),libB,I),
   holdsat(available(Book),libB,I),
   book(Book),
   user(User),
   inst(libB), instant(I).
%
% Translation of intBorrow(User,Book) initiates ['perm', ['intReturn', ['User', 'Book']]] if ['and', ['normalUser', ['User']], ['available', ['Book']]]
%
initiated(perm(intReturn(User,Book)),libB,I) :-
   occurred(intBorrow(User,Book),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   holdsat(normalUser(User),libB,I),
   holdsat(available(Book),libB,I),
   book(Book),
   user(User),
   inst(libB), instant(I).
%
% Translation of intBorrow(User,Book) initiates ['pow', ['intReturn', ['User', 'Book']]] if ['and', ['normalUser', ['User']], ['available', ['Book']]]
%
initiated(pow(libB,intReturn(User,Book)),libB,I) :-
   occurred(intBorrow(User,Book),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   holdsat(normalUser(User),libB,I),
   holdsat(available(Book),libB,I),
   book(Book),
   user(User),
   inst(libB), instant(I).
%
% Translation of intBorrow(User,Book) initiates ['borrowed', ['User', 'Book']] if ['and', ['and', ['and', ['normalUser', ['User']], ['available', ['Book']]], ['loans', ['User', 'Number']]], ['next', ['Number', 'NewNumber']]]
%
initiated(borrowed(User,Book),libB,I) :-
   occurred(intBorrow(User,Book),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   holdsat(normalUser(User),libB,I),
   holdsat(available(Book),libB,I),
   holdsat(loans(User,Number),libB,I),
   holdsat(next(Number,NewNumber),libB,I),
   number(NewNumber),
   book(Book),
   user(User),
   number(Number),
   inst(libB), instant(I).
%
% Translation of intBorrow(User,Book) initiates ['onLoan', ['Book']] if ['and', ['and', ['and', ['normalUser', ['User']], ['available', ['Book']]], ['loans', ['User', 'Number']]], ['next', ['Number', 'NewNumber']]]
%
initiated(onLoan(Book),libB,I) :-
   occurred(intBorrow(User,Book),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   holdsat(normalUser(User),libB,I),
   holdsat(available(Book),libB,I),
   holdsat(loans(User,Number),libB,I),
   holdsat(next(Number,NewNumber),libB,I),
   number(NewNumber),
   book(Book),
   user(User),
   number(Number),
   inst(libB), instant(I).
%
% Translation of intBorrow(User,Book) initiates ['loans', ['User', 'NewNumber']] if ['and', ['and', ['and', ['normalUser', ['User']], ['available', ['Book']]], ['loans', ['User', 'Number']]], ['next', ['Number', 'NewNumber']]]
%
initiated(loans(User,NewNumber),libB,I) :-
   occurred(intBorrow(User,Book),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   holdsat(normalUser(User),libB,I),
   holdsat(available(Book),libB,I),
   holdsat(loans(User,Number),libB,I),
   holdsat(next(Number,NewNumber),libB,I),
   number(NewNumber),
   book(Book),
   user(User),
   number(Number),
   inst(libB), instant(I).
%
% Translation of intBorrow(User,Book) initiates ['obl', [['intReturn', ['User', 'Book']], ['due', ['User', 'Book']], ['issueFine', ['User', 'Book']]]] if ['and', ['and', ['and', ['normalUser', ['User']], ['available', ['Book']]], ['loans', ['User', 'Number']]], ['next', ['Number', 'NewNumber']]]
%
initiated(obl(intReturn(User,Book),due(User,Book),issueFine(User,Book)),libB,I) :-
   occurred(intBorrow(User,Book),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   holdsat(normalUser(User),libB,I),
   holdsat(available(Book),libB,I),
   holdsat(loans(User,Number),libB,I),
   holdsat(next(Number,NewNumber),libB,I),
   number(NewNumber),
   book(Book),
   user(User),
   number(Number),
   inst(libB), instant(I).
%
% Translation of intExtRegister(User) initiates ['perm', ['extBorrow', ['User', 'Book']]] if []
%
initiated(perm(extBorrow(User,Book)),libB,I) :-
   occurred(intExtRegister(User),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   user(User),
   book(Book),
   inst(libB), instant(I).
%
% Translation of intExtRegister(User) initiates ['perm', ['intBorrow', ['User', 'Book']]] if []
%
initiated(perm(intBorrow(User,Book)),libB,I) :-
   occurred(intExtRegister(User),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   user(User),
   book(Book),
   inst(libB), instant(I).
%
% Translation of intExtRegister(User) initiates ['pow', ['intBorrow', ['User', 'Book']]] if []
%
initiated(pow(libB,intBorrow(User,Book)),libB,I) :-
   occurred(intExtRegister(User),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   user(User),
   book(Book),
   inst(libB), instant(I).
%
% Translation of intExtRegister(User) initiates ['registeredUser', ['User']] if []
%
initiated(registeredUser(User),libB,I) :-
   occurred(intExtRegister(User),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   user(User),
   inst(libB), instant(I).
%
% Translation of intExtRegister(User) initiates ['allowance', ['User', '1']] if []
%
initiated(allowance(User,1),libB,I) :-
   occurred(intExtRegister(User),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   user(User),
   inst(libB), instant(I).
%
% Translation of intExtRegister(User) initiates ['loans', ['User', '0']] if []
%
initiated(loans(User,0),libB,I) :-
   occurred(intExtRegister(User),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   user(User),
   inst(libB), instant(I).
%
% Translation of intRegister(User) initiates ['perm', ['borrow', ['User', 'Book']]] if []
%
initiated(perm(borrow(User,Book)),libB,I) :-
   occurred(intRegister(User),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   user(User),
   book(Book),
   inst(libB), instant(I).
%
% Translation of intRegister(User) initiates ['perm', ['intBorrow', ['User', 'Book']]] if []
%
initiated(perm(intBorrow(User,Book)),libB,I) :-
   occurred(intRegister(User),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   user(User),
   book(Book),
   inst(libB), instant(I).
%
% Translation of intRegister(User) initiates ['pow', ['intBorrow', ['User', 'Book']]] if []
%
initiated(pow(libB,intBorrow(User,Book)),libB,I) :-
   occurred(intRegister(User),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   user(User),
   book(Book),
   inst(libB), instant(I).
%
% Translation of intRegister(User) initiates ['registeredUser', ['User']] if []
%
initiated(registeredUser(User),libB,I) :-
   occurred(intRegister(User),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   user(User),
   inst(libB), instant(I).
%
% Translation of intRegister(User) initiates ['allowance', ['User', '2']] if []
%
initiated(allowance(User,2),libB,I) :-
   occurred(intRegister(User),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   user(User),
   inst(libB), instant(I).
%
% Translation of intRegister(User) initiates ['loans', ['User', '0']] if []
%
initiated(loans(User,0),libB,I) :-
   occurred(intRegister(User),libB,I),
   holdsat(live(libB),libB,I), inst(libB),
   user(User),
   inst(libB), instant(I).
%
% terminate rules
%
%
% Translation of intReturn(User,Book) terminates ['onLoan', ['Book']] if []
%
terminated(onLoan(Book),libB,I) :-
   occurred(intReturn(User,Book),libB,I),
   holdsat(live(libB),libB,I),inst(libB),
   book(Book),
   user(User),
   inst(libB), instant(I).
%
% Translation of intReturn(User,Book) terminates ['borrowed', ['User', 'Book']] if []
%
terminated(borrowed(User,Book),libB,I) :-
   occurred(intReturn(User,Book),libB,I),
   holdsat(live(libB),libB,I),inst(libB),
   book(Book),
   user(User),
   inst(libB), instant(I).
%
% Translation of intReturn(User,Book) terminates ['loans', ['User', 'Number']] if []
%
terminated(loans(User,Number),libB,I) :-
   occurred(intReturn(User,Book),libB,I),
   holdsat(live(libB),libB,I),inst(libB),
   book(Book),
   user(User),
   number(Number),
   inst(libB), instant(I).
%
% Translation of intBorrow(User,Book) terminates ['loans', ['User', 'Number']] if ['and', ['normalUser', ['User']], ['available', ['Book']]]
%
terminated(loans(User,Number),libB,I) :-
   occurred(intBorrow(User,Book),libB,I),
   holdsat(live(libB),libB,I),inst(libB),
   holdsat(normalUser(User),libB,I),
   holdsat(available(Book),libB,I),
   book(Book),
   user(User),
   number(Number),
   inst(libB), instant(I).
%
% noninertial rules
%
%
% Translation of available(Book) when ['and', ['inCollection', ['Book']], ['not', ['onLoan', ['Book']]]]
holdsat(available(Book),libB,I) :-
   holdsat(inCollection(Book),libB,I),
   not
   holdsat(onLoan(Book),libB,I),
   book(Book),
   inst(libB), instant(I).
%
% Translation of normalUser(User) when ['and', ['and', ['and', ['registeredUser', ['User']], ['allowance', ['User', 'Max']]], ['loans', ['User', 'Number']]], ['<', ['Number', 'Max']]]
holdsat(normalUser(User),libB,I) :-
   holdsat(registeredUser(User),libB,I),
   holdsat(allowance(User,Max),libB,I),
   holdsat(loans(User,Number),libB,I),
   Number<Max,
   number(Max),
   user(User),
   number(Number),
   inst(libB), instant(I).
%
% -------------------------------PART 3-------------------------------
%
%
% initially
%
% no creation event
holdsat(live(libB),libB,I) :- start(I), inst(libB).
holdsat(perm(null),libB,I) :- start(I), inst(libB).
% initially: perm(register(User))
holdsat(perm(register(User)),libB,I) :-
   user(User),
   inst(libB), start(I).
% initially: perm(intRegister(User))
holdsat(perm(intRegister(User)),libB,I) :-
   user(User),
   inst(libB), start(I).
% initially: pow(libB,intRegister(User))
holdsat(pow(libB,intRegister(User)),libB,I) :-
   user(User),
   inst(libB), start(I).
% initially: perm(due(User,Book))
holdsat(perm(due(User,Book)),libB,I) :-
   book(Book),
   user(User),
   inst(libB), start(I).
% initially: pow(libB,due(User,Book))
holdsat(pow(libB,due(User,Book)),libB,I) :-
   book(Book),
   user(User),
   inst(libB), start(I).
% initially: inCollection(book1_b)
holdsat(inCollection(book1_b),libB,I) :-
   inst(libB), start(I).
% initially: inCollection(book2_b)
holdsat(inCollection(book2_b),libB,I) :-
   inst(libB), start(I).
% initially: next(0,1)
holdsat(next(0,1),libB,I) :-
   inst(libB), start(I).
% initially: next(1,2)
holdsat(next(1,2),libB,I) :-
   inst(libB), start(I).
% initially: next(2,3)
holdsat(next(2,3),libB,I) :-
   inst(libB), start(I).
% initially: next(3,4)
holdsat(next(3,4),libB,I) :-
   inst(libB), start(I).
% initially: next(4,5)
holdsat(next(4,5),libB,I) :-
   inst(libB), start(I).
% initially: member(bob)
holdsat(member(bob),libB,I) :-
   inst(libB), start(I).
% initially: perm(extRegister(User))
holdsat(perm(extRegister(User)),libB,I) :-
   user(User),
   inst(libB), start(I).
% initially: perm(intExtRegister(User))
holdsat(perm(intExtRegister(User)),libB,I) :-
   user(User),
   inst(libB), start(I).
% initially: pow(libB,intExtRegister(User))
holdsat(pow(libB,intExtRegister(User)),libB,I) :-
   user(User),
   inst(libB), start(I).
%
% End of file
%
