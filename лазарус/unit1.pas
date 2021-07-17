unit Unit1;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, StdCtrls, ExtCtrls,
  ComCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    Amp1: TEdit;
    Amp2: TEdit;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    pb: TPaintBox;
    sp1: TEdit;
    sp2: TEdit;
    bet1: TEdit;
    bet2: TEdit;
    sbet1: TTrackBar;
    sbet2: TTrackBar;
    Timer1: TTimer;
    sAmp1: TTrackBar;
    ssp1: TTrackBar;
    ssp2: TTrackBar;
    sAmp2: TTrackBar;
    Timer2: TTimer;
    //procedure Amp1Change(Sender: TObject);
    //procedure Amp2Change(Sender: TObject);
    procedure bet2Change(Sender: TObject);
    procedure CheckBox1Change(Sender: TObject);
    procedure CheckBox3Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure sAmp1Change(Sender: TObject);
    procedure sAmp2Change(Sender: TObject);
    procedure sbet1Change(Sender: TObject);
    procedure sbet2Change(Sender: TObject);
    //procedure sp1Change(Sender: TObject);
    //procedure sp2Change(Sender: TObject);
    procedure ssp1Change(Sender: TObject);
    procedure ssp2Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure Timer2Timer(Sender: TObject);
  private
    procedure main();
    procedure draw_grid();
   // procedure draw_axis();
    procedure draw_lis();
    procedure calculate();
    function pp(x,y:real):Tpoint;
  public
    fig,sin1,sin2, ssin:array of Tpoint;
    A1,A2,w1,w2,b1,b2:real;
    t1,t2:real;

    ed,del,y0,x0:integer;
  end;

var
  Form1: TForm1;

implementation


{$R *.lfm}


{ TForm1 }
procedure Tform1.calculate();
var
   i:integer;
   p:Tpoint;
begin

  setlength(fig,1001);

  for i:=0 to 1000 do
      begin
      fig[i]:= pp(A2*sin(w2*i*2*pi/1000+b2),A1*sin(w1*i*2*pi/1000+b1));
      end;


  setlength(sin1,round(4*pi*pb.Width/ (ed*w1)+0.5)+1);
  for i:=0 to round(4*pi*pb.Width / (ed*w1)+0.5) do
      begin
      p.x:=i;
      p.y:=pb.Height- (ed*del)*round(pb.Height / (ed*del))div 2 - round(pb.height*A1*sin(b1+i/round(2*(pb.Width / ed)/w1+0.5))/60) ;
      sin1[i]:= p;
      end;

  setlength(sin2,round(0.5+4*pi*pb.Height / (ed*w2))+1);
  for i:=0 to round(0.5+4*pi*(pb.Height / ed)/w2) do
      begin
      p.y:=pb.Height-i;
      p.x:=(ed*del)*round(pb.width / (ed*del))div 2 +round(pb.width*A2*sin(b2+i/round(0.5+2*(pb.Height / (ed*w2))))/60);
      sin2[i]:= p;
      end;
  t1:=0;
  t2:=0;
end;

function TForm1.pp(x,y:real):Tpoint;
var
  w,h:integer;
begin
  w:=pb.width;
  h:=pb.height;
  pp.x:= (ed*del)*round(w / (ed*del)) div 2 + round(x*(w/60));
  pp.y:= h - (ed*del)*round(h / (ed*del))div 2- round(y*(h/60));

end;

procedure TForm1.sAmp1Change(Sender: TObject);
begin
     Amp1.Text:= floattostr(sAmp1.Position);
     A1 := sAmp1.Position;
     t1 := 0;
     t2 := 0;
     calculate();
     main();

end;

procedure TForm1.sAmp2Change(Sender: TObject);
begin
     Amp2.Text:= floattostr(sAmp2.Position);
     A2 := sAmp2.Position;
     t1 := 0;
     t2 := 0;
     calculate();
     main();
end;

procedure TForm1.sbet1Change(Sender: TObject);
begin
  bet1.text:=inttostr(sbet1.position);
  b1:=sbet1.position*2*pi/180;
  t1 := 0;
  t2 := 0;

  calculate();
     main();
end;

procedure TForm1.sbet2Change(Sender: TObject);
begin
  bet2.text:=inttostr(sbet2.position);
  b2:=sbet2.position*2*pi/180;
  t1 := 0;
  t2 := 0;
  calculate();
     main();
end;

//procedure TForm1.sp2Change(Sender: TObject);
//var
//  code:integer;
//begin
//     val(sp2.Text,w2,code);
//     if (code = 0) and (w2>=0) then
//        begin
//           if  (w2 <= 10) then
//              ssp2.position:= trunc(w2*10);
//        end
//     else
//         sp2.Text:= floattostr(ssp2.Position/10);
//
//     main();
//end;

procedure TForm1.ssp1Change(Sender: TObject);
begin
    sp1.Text:= floattostr(ssp1.Position);
    w1:= ssp1.Position*2*pi;
    t1 := 0;
  t2 := 0;

  calculate();
    main();
end;

procedure TForm1.ssp2Change(Sender: TObject);
begin
    sp2.Text:= floattostr(ssp2.Position);
    w2:= ssp2.Position*2*pi;
    t1 := 0;
   t2 := 0;
    calculate();
     main();

end;

procedure TForm1.Timer1Timer(Sender: TObject);
var
  r:integer;
  ps1,ps2,pl:Tpoint;
begin

  t1:=(t1 + 0.01);
  t2:=(t2 + 0.01);


  if (t1) > 2*pi/w1 then
     t1 := 0;
  if (t2) > 2*pi/w2 then
     t2 := 0;


  main();

  r:=10;
  //pb.Height- (ed*del)*round(pb.Height / (ed*del))div 2 - pb.height*A1*   /60
  ps1 := sin1[round(t1*round(4*pi*pb.width/(ed*w1))/(2*pi/w1))];
  ps2 := sin2[round(t2*round(4*pi*pb.height/(ed*w2))/(2*pi/w2))];


  pb.canvas.pen.Color:=ClRed;
  pb.canvas.brush.Color:=ClRed;


  pb.Canvas.Ellipse(ps1.x+r,ps1.y+r,ps1.x-r,ps1.y-r);
  pb.canvas.line(ps1.x,ps1.y,ps2.x, ps1.y);

  pb.canvas.pen.Color:=ClBlue;
  pb.canvas.brush.Color:=ClBlue;

  pb.Canvas.Ellipse(ps2.x+r,ps2.y+r,ps2.x-r,ps2.y-r);
  pb.canvas.line(ps2.x,ps2.y,ps2.x, ps1.y);

  pb.canvas.brush.Color:=ClGreen;

  pb.Canvas.Ellipse(ps2.x+r,ps1.y+r,ps2.x-r,ps1.y-r);

end;

procedure TForm1.Timer2Timer(Sender: TObject);
begin
  //t1:=(t1 + 0.1);
  //t2:=(t2 + 0.1);
  //
  //if (t1) > (2*pi) then
  //   t1 := 0;
  //if (t2) > (2*pi) then
  //   t2 := 0;
end;



procedure TForm1.CheckBox1Change(Sender: TObject);
begin
  Timer1.Enabled:= checkbox1.checked;
  //Timer2.Enabled:= checkbox1.checked;
end;

procedure TForm1.CheckBox3Change(Sender: TObject);
begin

end;

procedure TForm1.bet2Change(Sender: TObject);
begin

end;

procedure TForm1.FormCreate(Sender: TObject);
var
  i:integer;
  p:Tpoint;
begin
  A1:=0;
  A2:=0;
  w1:=6.28;
  w2:=6.28;
  ed:=8;
  del:=10;

end;

procedure Tform1.draw_lis();
var
   p1,p2:Tpoint;
begin
  pb.canvas.pen.color:=clgreen;
  pb.canvas.Polyline(fig);

  pb.canvas.pen.color:=clred;
  pb.canvas.Polyline(sin1);

  pb.canvas.pen.color:=clBlue;
  pb.canvas.Polyline(sin2);

  //p1:= pp(A1*sin(w1*(t1-Timer1.Interval/10000)),A2*sin(w2*(t2-Timer1.Interval/10000)));
  //p2:= pp(A1*sin(w1*t1),A2*sin(w2*t2));
  //pb.canvas.line(p1,p2);
end;

procedure TForm1.FormResize(Sender: TObject);
begin
  main();
end;

procedure TForm1.draw_grid();
var
  i:integer;
begin

  for i:=0 to (ed*del) do
      begin
       pb.canvas.Pen.Width:=2;
       pb.canvas.pen.Color:=ClGray;
       if i mod del = 0 then
          begin
             pb.canvas.Pen.Width:=3;
             pb.canvas.pen.Color:=ClBlack;
          end;
       if i = ((ed*del) div 2)  then
          begin
             pb.canvas.Pen.Width:=5;
             pb.canvas.pen.Color:=ClBlack;
          end;
       pb.canvas.line(i*round(pb.Width / (ed*del)),0,i*round(pb.Width / (ed*del)),pb.Height);
      pb.canvas.line(0,pb.Height-i*round(pb.Height / (ed*del)),pb.Width,pb.Height-i*round(pb.Height / (ed*del)));
      end;





end;


//procedure TForm1.draw_axis();
//begin
//  pb.canvas.Pen.Width:=5;
//  pb.canvas.pen.Color:=ClBlack;
//  pb.canvas.line(0,pb.height div 2,pb.width,pb.height div 2);
//  pb.canvas.line(pb.width div 2,0,pb.width div 2,pb.height);
//end;
procedure TForm1.main();

begin
  pb.canvas.brush.Color:=ClWindow;
  pb.canvas.Rectangle(0,0,pb.Width,pb.height);
  draw_grid();
  //draw_axis();
  draw_lis();

  //
  //draw_dot();
  //draw_dot();
  //draw_dot();
  //
  //draw_sin();
  //draw_sin();

end;

end.

