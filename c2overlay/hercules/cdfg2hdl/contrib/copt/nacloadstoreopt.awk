t%0 <= ldc %1 ;
%2 <= load %3 , t%0 ;
=
%2 <= load %3 , %1 ;

t%0 <= ldc %1 ;
%2 <= store %3 , t%0 ;
=
%2 <= store %3 , %1 ;

t%0 <= mov %1 ;
%2 <= store t%0 , %1 ;
=
%2 <= self %1 ;

t%0 <= ldc %1 ;
t%2 <= ldc %3 ;
%4 <= store t%0 , t%2 ;
=
%4 <= store %1 , %3 ;

t%0 <= ldc %1 ;
%2 <= store t%0 , %3 ;
=
%2 <= store %1 , %3 ;
