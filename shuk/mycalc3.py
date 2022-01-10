

def Normdist(x1,xf1):
  
    sum = 0;
    for i in range(len(xf1)-1):
        aa = abs(xf1[i]-x1[i]);
        if aa>sum:
            sum = aa;
    return sum;