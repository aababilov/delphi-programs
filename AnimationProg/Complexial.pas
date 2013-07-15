unit Complexial;

interface
type complex=record
             r,i:real;
        end;
procedure CSqr(a:complex;var result:complex);
procedure CAdd(a,b:complex;var result:complex);
procedure ToComplex(a,b:real; var result:complex);

implementation
procedure CSqr;
begin
     result.r:=(Sqr(a.r)-Sqr(a.i));
     result.i:=2*a.r*a.i;
end;

procedure CAdd;
begin
     result.r:=a.r+b.r;
     result.i:=a.i+b.i;
end;

procedure ToComplex;
begin
     result.r:=a;
     result.i:=b;
end; 
end.
 