% shawdow(picture, visibility) draws a shadow of the picture (but not the picture) visibility should be between 0-1, with 0 being invisible and 1 being a shadow that is reduces the background brightness by 20%. If visibility is greater than 1, it will make the shadow even darker, but 20% seems to be plenty. (change 0.8background to something else to change the maximum darkness.) The picture should be shifted and rotated in the command, not afterwards. E.g. shadow(cow rotate 45 shifted (10cm, 5cm), .3);.
  vardef shadow(expr p, v) = 
    draw redecorated (draw p) withcolor v[background,0.8background];
  enddef; 

picture ball;
	ball := image(
		draw fullcircle scaled 1cm
      			withshademethod "circular"
			withshadecenter (.25,.25)
       		withcolor "white" shadedinto black;
		draw fullcircle scaled 1cm withpen pencircle scaled 0.8pt;);

picture littleball;
	littleball := image(
		draw fullcircle scaled 0.2cm
      			withshademethod "circular"
			withshadecenter (0.2, 0.2)
       		withcolor "white" shadedinto black;
		draw fullcircle scaled 0.2cm withpen pencircle scaled 0.8pt;);




% This is from the feynmp package
%input feynmp

curly_len := 3mm;

vardef pixlen (expr p, n) =
  for k=1 upto length(p): + segment_pixlen (subpath (k-1,k) of p, n) endfor
enddef;

vardef segment_pixlen (expr p, n) =
  for k=1 upto n: + abs (point k/n of p - point (k-1)/n of p) endfor
enddef;

vardef curly expr p =
 save cpp;
 numeric cpp;
 cpp := ceiling (pixlen (p, 10) / curly_len) / length p;
 if cycle p:
   for k=0 upto cpp*length(p) - 1:
     point (k+.33)/cpp of p
           {direction (k+.33)/cpp of p rotated 90} ..
     point (k-.33)/cpp of p
           {direction (k-.33)/cpp of p rotated -90} ..
   endfor
   cycle
 else:
   point 0 of p
         {direction 0 of p rotated -90} ..
   for k=1 upto cpp*length(p) - 1:
     point (k+.33)/cpp of p
           {direction (k+.33)/cpp of p rotated 90} ..
     point (k-.33)/cpp of p
           {direction (k-.33)/cpp of p rotated -90} ..
   endfor
   point infinity of p
         {direction infinity of p rotated 90}
 fi
enddef;