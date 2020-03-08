program NeyroMatch;

const 
  len = 15;

var
  white1 : array [1..len] of integer;
  black1 : array [1..len] of integer;
  white2 : array [1..len] of integer;
  black2 : array [1..len] of integer;
  
  tmp1 : array [1..len] of integer;
  tmp2 : array [1..len] of integer;
  
  bunch : integer;
  i : integer;
  j : integer;
  human : integer;
  win : integer;
  input : integer;
  v : integer;
  t : real;
  
function Game(): integer;
var
  i : integer;
begin
  bunch:= len;
  
  if(human = 1) then
  begin
        writeln('Новая игра. Спичек в кучке ', bunch);
  end;
  
  for i:=1 to len do
  begin
    tmp1[i]:=0;
    tmp2[i]:=0;
  end;
  
  win:=0;
  
  while(bunch > 2) do
  begin  
    if(random()<(white1[bunch]/(white1[bunch]+white2[bunch]))) then
    begin
      tmp1[bunch] := 1;
      bunch := bunch - 1;
      if(human = 1) then 
        writeln('Компьютер берет 1 спичку');
    end
    else
    begin
      tmp1[bunch] := 2;
      bunch := bunch - 2;
      if(human = 1) then
        writeln('Компьютер берет 2 спички');
    end;
    
    if(bunch <= 2) then
    begin
      if(human = 1) then       
      begin
        writeln('========= Человек выиграл ============');
      end;
      win := 1;
      break;
    end
    else
    begin
      if(human = 1) then
        writeln('Спичек в кучке ', bunch);
    end;
    
    if(human = 1) then
    begin
      writeln('Ход человека');
      read(input);
      bunch := bunch - input;
    end
    else
    begin
      if(random()<(black1[bunch]/(black1[bunch]+black2[bunch]))) then
      begin
        tmp2[bunch] := 1;
        bunch := bunch - 1;
      end
      else
      begin
        tmp2[bunch] := 2;
        bunch := bunch - 2;
      end;
    end;
    
    if(bunch <= 2) then
    begin
      if(human = 1) then
      begin
        writeln('========= Компьютер выиграл =========');
      end;
      win := 2;
      break;
    end
    else
    begin
      if(human = 1) then
      begin
        writeln('Спичек в кучке ', bunch);
      end;
    end;
  end;
  
  if(win = 2) then
  begin
    for i:=1 to len do
    begin
      if(tmp1[i] = 1) then
        white1[i] := white1[i] + 1;
      if(tmp1[i] = 2) then
        white2[i] := white2[i] + 1;
    end;
  end
  else
  begin
    for i:=1 to len do
    begin
       if (tmp1[i] > 0) then
       begin
         if(tmp1[i] = 1) and (white1[i] > 1) then
           white1[i] := white1[i] - 1;              
         if(tmp1[i] = 2) and (white2[i] > 1) then
           white2[i] := white2[i] - 1;
         break;
       end;
    end;
  end;
  
  if(win = 1) then
  begin
    for i:=1 to len do
      if(tmp2[i] = 1) then
        black1[i] := black1[i] + 1;
      if(tmp2[i] = 2) then
        black2[i] := black2[i] + 1;
  end
  else
  begin
    for i:=1 to len do
    begin
      if(tmp2[i] > 0) then
      begin
        if(tmp2[i] = 1) and (black1[i] > 1) then
          black1[i] := black1[i] + 1;               
        if(tmp2[i] = 2) and (black2[i] > 1) then
          black2[i] := black2[i] - 1;
        break
      end;
    end;
  end;
  Result := win;
end;

begin
  for i:=1 to len do
  begin
    tmp1[i]:=0;
    tmp2[i]:=0;
    white1[i]:=1;
    white2[i]:=1;
    black1[i]:=1;
    black2[i]:=1;
  end;
  
  human := 0;
  
  t := 1;

  for j:=1 to 10 do 
    // Число 10 в данной строчке - количество итераций обучения
    // Чем больше число, тем дольше обучаеться нейросеть и тем лучше потом играет. 
    // Рекомендую значения от 10 до 100
  begin
    for i:=1 to j*25 do
    begin
        writeln('Процесс обучения... Проведено циклов - ', t);
        t:=t+1;
        Game();
    end;
  end;
  writeln();
  writeln(white1);
  writeln(white2);
  writeln(black1);
  writeln(black2);
  writeln();
    
  human := 1;
  while True do
    Game();
end.