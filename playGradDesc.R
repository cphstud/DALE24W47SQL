# lineært datasæt
a=1.5
b=2
x=1:10
y=a*x + b


y=a*x + b + runif(length(x),-2,2)

plot(x,y,ylim = c(0,max(y)))
model=lm(y~x)
model$coefficients

#Initialisering
#Tegn første linje med a0=0,b0=0
a0=0
b0=0
y0=a0*x+b0
abline(b0,a0,col="blue")
#Beregn afstand mellem fy0 og oy
#Sum kvadreret afstand d0 = sum(fy0-oy)^2
colsum0=sum((y-y0)^2)
prevcolsum=colsum0
#Tegn næste linje med a2=0.1, b2=0
#Beregn afstand mellem fy2 og oy
#Sum kvadreret afstand d2 = sum(fy2-oy)^2
#Sammenlign med den forrige afstand
#Hvis d2 < d1 prøver vi én gang til
counter=0
slope=0
slopeincr=0.1
bincr=0.1
tol=10
converge=F
b=min(y)
plot(x,y,ylim = c(0,max(y)))
while (converge==F) {
  Sys.sleep(1)
  counter=counter+1
  slope=slope+slopeincr
  b=b-bincr
  yf=slope*x+b
  abline(b,slope,col="green")
  colsumnew=sum((y-yf)^2)
  diffdistnew=abs(colsumnew-prevcolsum)
  if (diffdistnew < tol) {
    converge = T
    print(c("slope:",slope,"b:",b))
  } else {
    print(c("continue slope:",slope,"b:",b))
    prevcolsum=colsumnew
  }
}
#Ellers stop

  