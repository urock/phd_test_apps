
import math

from math import exp, sqrt, log  

infinity=10**8
eps = 10**(-8)
eps1=10**(-2)
pokmax=8

def check(x):
    Dnum = []
    for i in range(x):
        Dnum.append("Hello!")
    return Dnum


def Ro_1(z):
    
    return z

def Ro_2(z):
    if abs(z)>sqrt(infinity): 
        return 10**8
    else:
        return z

def Ro_3(z):
    
    return -z

def Ro_10(z):
    if z>=0: 
        return 1
    else:
        return -1

def Ro_4(z):
    
    return Ro_10(z)*sqrt(abs(z))

def Ro_5(z):
    if abs(z)>eps:
        return  1/z
    else:
        return Ro_10(z)/eps

def Ro_6(z):
    if z>-log(eps):
        return -log(eps)
    else:
        return exp(z)

def Ro_7(z):
    if abs(z)<exp(-pokmax):
        return log(eps)
    else:
        return log(abs(z))

def Ro_8(z):
    if abs(z)>-log(eps):    
        return Ro_10(z)
    else:
        return (1-exp(-z))/(1+exp(-z))

def Ro_9(z):
    if z>=0:
        return 1
    else:
        return 0

def Ro_11(z):
    
    return math.cos(z)

def Ro_12(z):
    
    return math.sin(z)

def Ro_13(z):

    return math.atan(z)

def Ro_14(z):
    if abs(z)>Ro_15(infinity):
        return Ro_10(z)*infinity
    else:
        return z*z*z

def Ro_15(z):
    if abs(z)<eps:
        return Ro_10(z)*eps
    else:
        return Ro_10(z)*exp(log(abs(z))/3)

def Ro_16(z):
    if abs(z)<1:
        return z
    else:
        return Ro_10(z)

def Ro_17(z):

  return Ro_10(z)*log(abs(z)+1)

def Ro_18(z):
    if abs(z)>-log(eps):
        return Ro_10(z)*infinity
    else:
        return Ro_10(z)*(exp(abs(z))-1);

def Ro_19(z):
    if abs(z)>1/eps:
        return Ro_10(z)*eps
    else:
        return Ro_10(z)*exp(-abs(z))

def Ro_20(z):

    return z/2

def Ro_21(z):
    
    return 2*z

def Ro_22(z):
    if z<0:
        return exp(z)-1
    else: 
        return 1-exp(-abs(z))

def Ro_23(z):
    if abs(z)>1/eps:
        return -Ro_10(z)/eps
    else:
        return z-z*z*z

def Ro_24(z):
    if z>infinity:
        return 1
    else:
        if exp(-z)>infinity:
           return 0
        else:
            return 1/(1+exp(-z))

def Ro_25(z):
    if z>0:
        return 1
    else:
        return 0

def Ro_26(z):
    if abs(z)<eps1:
        return 0
    else:
        return Ro_10(z)

def Ro_27(z):
    if abs(z)>1: 
        return Ro_10(z)
    else:
        return Ro_10(z)*(1-sqrt(1-z*z))

def Ro_28(z):
    if z*z>math.log(infinity): 
        return z*(1-eps)
    else:
        return z*(1-exp(-z*z))

def Xi_1(z1,z2):
  
    return z1+z2

def Xi_2(z1,z2):
    if abs(z1*z2)>infinity:
        return Ro_10(z1*z2)*infinity
    else:
        return z1*z2

def Xi_3(z1,z2):
    if z1>=z2:
        return z1
    else:
        return z2

def Xi_4(z1,z2):
    if z1<z2:
        return z1
    else:
        return z2

def Xi_5(z1,z2):
  
    return z1+z2-z1*z2

def Xi_6(z1,z2):
    
    return Ro_10(z1+z2)*sqrt(z1*z1+z2*z2)

def Xi_7(z1,z2):   
    
    return Ro_10(z1+z2)*(abs(z1)+abs(z2))

def Xi_8(z1,z2):

    return Ro_10(z1+z2)*Xi_2(abs(z1),abs(z2))
