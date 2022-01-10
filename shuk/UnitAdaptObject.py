
import calc3
import mycalc3
import math
import random
from math import exp, sqrt, log 

print("U-------------")
print(calc3.Ro_1(2))
print(calc3.Ro_2(2))
print(calc3.Ro_3(2))
print(calc3.Ro_4(2))
print(calc3.Ro_5(2))
print(calc3.Ro_6(2))
print(calc3.Ro_7(2))
print(calc3.Ro_8(2))
print(calc3.Ro_9(2))
print(calc3.Ro_10(2))
print(calc3.Ro_11(2))
print(calc3.Ro_12(2))
print(calc3.Ro_13(2))
print(calc3.Ro_14(2))
print(calc3.Ro_15(2))
print(calc3.Ro_16(2))
print(calc3.Ro_17(2))
print(calc3.Ro_18(2))
print(calc3.Ro_19(2))
print(calc3.Ro_20(2))
print(calc3.Ro_21(2))
print(calc3.Ro_22(2))
print(calc3.Ro_23(2))
print(calc3.Ro_24(2))
print(calc3.Ro_25(2))
print(calc3.Ro_26(2))
print(calc3.Ro_27(2))
print(calc3.Ro_28(2))
print("B---------------")
print(calc3.Xi_1(2,2))
print(calc3.Xi_2(2,2))
print(calc3.Xi_3(2,2))
print(calc3.Xi_4(2,2))
print(calc3.Xi_5(2,2))
print(calc3.Xi_6(2,2))
print(calc3.Xi_7(2,2))
print(calc3.Xi_8(2,2))


class TNetOper():    
    #L:integer; #dimention of network operator matrix
    L = 0
    #number of outputs - 1
    Mout = 0
    #Vs:TArrReal#set of variables - Переменная х1 и x2 
    Vs = []
    #Cs:TArrReal#set of parameters - значения параметров
    Cs = []
    #O1s:TArrInt#set of unary operations - задать все
    O1s = []
    #O2s:TArrInt#set of binary operations - хватит 1 и 2
    O2s = []
    #kP:integer#cardinal of the set of variables - количество операций
    kP = 0
    #kR:integer#cardinal of the set of parameters - количество
    kR = 0
    #kW:integer#cardinal of the set of unary operations - количество 
    kW = 0
    #kV:integer#cardinal of the set of binary operations - количество
    kV = 0
    #Pnum:TArrInt#vector of number nodes for variables - номера колонок переменных (нулевые колонки) - 0, 1
    Pnum = []
    #Rnum:TArrInt#vector of number nodes for parameters - номера колонок параметров (нулевые колонки) - 2, 3
    Rnum = []
    #Dnum:TArrInt#vector of number nodes for outputs - 7 номер колонки. Выход в z[Dnum[0]]
    Dnum = []
    #z:TArrReal#vector of nodes
    z = []
    #zs:TArrString#string for mathematical expression
    zs = []
    #Psi,Psi0:TArrArrInt#Network operator matrices
    Psi = []
    Psi0 = []

    #Constructor Create(Lay1,Mout1,kp1,kr1,kw1,kv1:integer);//create of NOP
    def __init__(self, Lay1,Mout1,kp1,kr1,kw1,kv1):
        self.L = Lay1;
        self.kP = kp1;
        self.kR = kr1;
        self.kW = kw1;
        self.kV = kv1;
        self.Mout = Mout1;
        self.infinity = 10**8;
        print("TNetOper created");
        self.Psi = self.setlength2(self.Psi,self.L,self.L);
        self.Psi0 = self.setlength2(self.Psi0,self.L,self.L);
        self.z = self.setlength1(self.z,self.L);
        self.zs = self.setlength1(self.zs,self.L);
        self.Vs = self.setlength1(self.Vs,self.kP);
        self.Cs = self.setlength1(self.Cs,self.kR);
        self.O1s = self.setlength1(self.O1s,self.kW);
        self.O2s = self.setlength1(self.O2s,self.kV);
        self.Pnum = self.setlength1(self.Pnum,self.kP);
        self.Rnum = self.setlength1(self.Rnum,self.kR);
        self.Dnum = self.setlength1(self.Dnum,self.Mout);
        
    
    def setlength1(self, List, Length):
        b = [];
        for i in range(Length):
            if len(List)-1>=i:
                b.append(List[i])
            else:
                b.append(0);
        return b;

    def setlength2(self, List, Lengt1, Lengt2):
        b = []
        for i in range(Lengt1):
            if len(List)-1>=i:
                b.append(List[i])
            else:
                b.append([]);
            for j in range(Lengt2):
                if len(List)-1>=i:
                    if len(List[i])>j:
                        b[i].append(List[i][j])
                else:
                    b[i].append(0);
        return b;

    #Procedure SetVs(vs1:TArrReal);
    def SetVs(self, vs1):
        for i in range(self.kP):
            self.Vs[i] = vs1[i];

    #Procedure SetCs(cs1:TArrReal);
    def SetCs(self, cs1):
        for i in range(self.kR):
            self.Cs[i] = cs1[i];

    #Procedure SetO1s(o1s1:TArrInt); 
    def SetO1s(self, o1s1):
        for i in range(self.kW):
            self.O1s[i] = o1s1[i]

    #Procedure SetO2s(o2s1:TArrInt);
    def SetO2s(self, o2s1):
        for i in range(self.kV):
            self.O2s[i] = o2s1[i]

    #Procedure SetPnum(pnum1:TArrInt);
    def SetPnum(self, pnum1):
        for i in range(self.kP):
            self.Pnum[i] = pnum1[i]

    #Procedure SetRnum(rnum1:TArrInt);
    def SetRnum(self, rnum1):
        for i in range(self.kR):
            self.Rnum[i] = rnum1[i]

    #Procedure SetDnum(dnum1:TArrInt);
    def SetDnum(self, dnum1):
        for i in range(self.Mout):
            self.Dnum[i] = dnum1[i]

    #Procedure SetPsiBas(Psi1:TArrArrInt);
    def SetPsiBas(self, Psi1):
        for i in range(self.L): 
            for j in range(self.L): 
                self.Psi0[i][j] = Psi1[i][j]                        

    #Procedure SetPsi(Psi1:TArrArrInt);
    def SetPsi(self, Psi1):
        for i in range(self.L): 
            for j in range(self.L): 
                self.Psi[i][j] = Psi1[i][j]

    def TestSource(self, j):
        flag = True 
        i = 0
        while (i<=len(self.Pnum)-1) and (j!=self.Pnum[i]):
            i=i+1
        if i<=len(self.Pnum)-1:
            flag = False
        else:
            i = 0
            while (i<=len(self.Rnum)-1) and (j!=self.Rnum[i]):
                i=i+1
            if i<=len(self.Rnum)-1:
                flag = False
        return flag

    #Procedure GenVar(var w:TArr4Int);
    def GenVar(self, w):
        w[0] = random.choice([0,1,2,3])
        if w[0] == 0 or w[0] == 2 or w[0]==3:
            w[1]=random.choice(range(self.L-1))
            w[2]=random.choice(range(self.L-w[1]-1))+w[1]+1
            #while not self.TestSource(w[2]):
            #    w[2]=w[2]+1
            w[3]=self.O1s[random.choice(range(self.kW))]
        elif w[0]==1:
            w[1]=random.choice(range(self.L))
            while not self.TestSource(w[1]):
                w[1]=w[1]+1
            w[2]=w[1]
            w[3] = self.O2s[random.choice(range(self.kV))]
        return w

    #Procedure PsitoPas;
    def PsitoPas(self):
        for i in range(self.L):
            if self.Psi[i][i]==0 or self.Psi[i][i]==4:
                self.zs[i] = "0"
            elif self.Psi[i][i] == 1:
                self.zs[i] = "1"
            elif self.Psi[i][i] == 2:
                self.zs[i] = "-inf"
            elif self.Psi[i][i] == 3:
                self.zs[i] = "inf"
        for i in range(self.kP):
            self.zs[self.Pnum[i]] = "x["+str(i)+"]"
        for i in range(self.kR):
            self.zs[self.Rnum[i]] = "q["+str(i)+"]"
        for i in range(self.L):
            for j in range(i+1,self.L):
                if self.Psi[i][j]!=0:
                    if self.Psi[i][j] == 1:
                        zz = self.zs[i]
                    else:
                        zz = "Ro_"+str(self.Psi[i][j])+"("+self.zs[i]+")"
                    if (self.Psi[j][j]==0 and self.zs[j]=="0") or (self.Psi[j][j]==1 and self.zs[j]=="1") or (self.Psi[j][j]==2 and self.zs[j]=="-inf") or (self.Psi[j][j]==3 and self.zs[j]=="inf") or (self.Psi[j][j]==4 and self.zs[j]=="0"):
                        self.zs[j] = zz
                    else:
                        self.zs[j] = "Xi_"+str(self.Psi[j][j])+"("+self.zs[j]+","+zz+")"
    
    #Procedure PsitoPasStr;                    
    def PsitoPasStr(self):
        for j in reversed(range(self.L-1)):
            self.zs[j] = "z"+str(j)+"="
            if self.Psi[j][j] ==1:
                self.zs[j] = self.zs[j]+"Sum("
            elif self.Psi[j][j] ==2:
                self.zs[j] = self.zs[j]+"Prod("
            elif self.Psi[j][j] ==3:
                self.zs[j] = self.zs[j]+"Min("
            elif self.Psi[j][j] ==4:
                self.zs[j] = self.zs[j]+"Max("
            elif self.Psi[j][j] ==5:
                self.zs[j] = self.zs[j]+"Pol("
            elif self.Psi[j][j] ==6:
                self.zs[j] = self.zs[j]+"Norm2("
            elif self.Psi[j][j] ==7:
                self.zs[j] = self.zs[j]+"NormMax("
            elif self.Psi[j][j] ==8:
                self.zs[j] = self.zs[j]+"NormProd("
            for i in reversed(range(j-1)):
                if self.Psi[i][j] !=0:
                    if self.Psi[i][j]!=1:
                        self.zs[j] = self.zs[j]+"Ro_"+str(self.Psi[i][j])+"(z_"+str(i)+"),"
                    else:
                        self.zs[j] = +"z_"+str(i)+","
                    if self.zs[j][len(self.zs[j])-1] ==",":
                        self.zs[j][len(self.zs[j])-1] = ")"
                    else:
                        self.zs[j] = self.zs[j]+")"
            for i in range(self.kP):
                self.zs[self.Pnum[i]] = "z_"+str(self.Pnum[i])+"=x_"+str(i)
            for i in range(self.kR):
                self.zs[self.Rnum[i]] = "z_"+str(self.Rnum[i])+"=q_"+str(i)
    
    #Procedure Variations(w:TArr4Int);
    def Variations(self,w):
        # Элементарные операции
        # 0 - замена недиагонального элемента
        # 1 - замена диагонального элемента
        # 2 - добавление дуги
        # 3 - удаление дуги
        if (w[0]!=0)or(w[1]!=0)or(w[2]!=0):
            if w[0] == 0:
                if self.Psi[w[1]][w[2]]!=0:
                    self.Psi[w[1]][w[2]] = w[3]
            elif w[0] == 1:
                if self.Psi[w[1]][w[1]]!=0:
                    self.Psi[w[1]][w[1]] = w[3]
            elif w[0] == 2:
                if self.Psi[w[1]][w[2]]==0:
                    if self.Psi[w[2]][w[2]]!= 0:
                        self.Psi[w[1]][w[2]] = w[3]
            elif w[0] == 3:
                s1 = 0
                for i in range(w[2]):
                    if self.Psi[i][w[2]]!=0:
                        s1 = s1+1
                s2 = 0
                for j in range(w[1]+1,self.L):
                    if self.Psi[w[1]][j]!=0:
                        s2 = s2+1
                if s1>1:
                    if s2>1:
                        self.Psi[w[1]][w[2]] = 0
    
    #Procedure PsitoTex;              
    def PsitoTex(self):
        zz=""
        for i in range(self.L):
            if self.Psi[i][i]==0 or self.Psi[i][i] == 4:
                self.zs[i]="0"
            elif self.Psi[i][i]==1:
                self.zs[i] = "1"
            elif self.Psi[i][i]==2:
                self.zs[i] = "-\infinity"
            elif self.Psi[i][i]==3:
                self.zs[i] = "\infinity"
        for i in range(self.kP):
            self.zs[self.Pnum[i]] = "x_{"+str(i)+"}"
        for i in range(self.kR):
            self.zs[self.Pnum[i]] = "q_{"+str(i)+"}"
        for i in range(self.L):
            for j in range(i+1,self.L):
                if self.Psi[i][j]!=0:
                    if self.Psi[i][j]==1:
                        zz = self.zs[i]
                    else:
                        zz = "\rho_{"+str(self.Psi[i][j])+"}("+self.zs[i]+")"
                    if ((self.Psi[j][j])==0 and (self.zs[j]=="0")) or ((self.Psi[j][j])==1 and (self.zs[j]=="1")) or ((self.Psi[j][j])==2 and (self.zs[j]=="-\infinity")) or ((self.Psi[j][j])==3 and (self.zs[j]=="\infinity")) or ((self.Psi[j][j])==4 and (self.zs[j]=="0")):
                        self.zs[j] = zz
                    else:
                        self.zs[j] = "\chi_{"+str(Psi[j][j])+"}("+zs[j]+","+zz+")"
    
    #Procedure RPControl;                  
    def RPControl(self):
        for i in range(self.L):
            self.z[i] = self.Psi[i][i];
        for i in range(self.kP):
            self.z[self.Pnum[i]] = self.Vs[i]
        for i in range(self.kR):
            self.z[self.Rnum[i]] = self.Cs[i]
        for i in range(self.L):
            for j in range(i+1,self.L):
                if self.Psi[i][j]!=0:
                    if self.Psi[i][j]==1:
                        zz = calc3.Ro_1(self.z[i])
                    elif self.Psi[i][j]==2:
                        zz = calc3.Ro_2(self.z[i])
                    elif self.Psi[i][j]==3:
                        zz = calc3.Ro_3(self.z[i])
                    elif self.Psi[i][j]==4:
                        zz = calc3.Ro_4(self.z[i])
                    elif self.Psi[i][j]==5:
                        zz = calc3.Ro_5(self.z[i])
                    elif self.Psi[i][j]==6:
                        zz = calc3.Ro_6(self.z[i])
                    elif self.Psi[i][j]==7:
                        zz = calc3.Ro_7(self.z[i])
                    elif self.Psi[i][j]==8:
                        zz = calc3.Ro_8(self.z[i])
                    elif self.Psi[i][j]==9:
                        zz = calc3.Ro_9(self.z[i])
                    elif self.Psi[i][j]==10:
                        zz = calc3.Ro_10(self.z[i])
                    elif self.Psi[i][j]==11:
                        zz = calc3.Ro_11(self.z[i])
                    elif self.Psi[i][j]==12:
                        zz = calc3.Ro_12(self.z[i])
                    elif self.Psi[i][j]==13:
                        zz = calc3.Ro_13(self.z[i])
                    elif self.Psi[i][j]==14:
                        zz = calc3.Ro_14(self.z[i])
                    elif self.Psi[i][j]==15:
                        zz = calc3.Ro_15(self.z[i])
                    elif self.Psi[i][j]==16:
                        zz = calc3.Ro_16(self.z[i])
                    elif self.Psi[i][j]==17:
                        zz = calc3.Ro_17(self.z[i])
                    elif self.Psi[i][j]==18:
                        zz = calc3.Ro_18(self.z[i])
                    elif self.Psi[i][j]==19:
                        zz = calc3.Ro_19(self.z[i])
                    elif self.Psi[i][j]==20:
                        zz = calc3.Ro_20(self.z[i])
                    elif self.Psi[i][j]==21:
                        zz = calc3.Ro_21(self.z[i])
                    elif self.Psi[i][j]==22:
                        zz = calc3.Ro_22(self.z[i])
                    elif self.Psi[i][j]==23:
                        zz = calc3.Ro_23(self.z[i])
                    elif self.Psi[i][j]==24:
                        zz = calc3.Ro_24(self.z[i])
                    elif self.Psi[i][j]==25:
                        zz = calc3.Ro_25(self.z[i])
                    elif self.Psi[i][j]==26:
                        zz = calc3.Ro_26(self.z[i])
                    elif self.Psi[i][j]==27:
                        zz = calc3.Ro_27(self.z[i])
                    elif self.Psi[i][j]==28:
                        zz = calc3.Ro_28(self.z[i])
                    if self.Psi[j][j]==0:
                        self.z[j] = calc3.Xi_1(self.z[j],zz)
                    elif self.Psi[j][j]==1:
                        self.z[j] = calc3.Xi_2(self.z[j],zz)
                    elif self.Psi[j][j]==2:
                        self.z[j] = calc3.Xi_3(self.z[j],zz)
                    elif self.Psi[j][j]==3:
                        self.z[j] = calc3.Xi_4(self.z[j],zz)
                    elif self.Psi[j][j]==4:
                        self.z[j] = calc3.Xi_5(self.z[j],zz)
                    elif self.Psi[j][j]==5:
                        self.z[j] = calc3.Xi_6(self.z[j],zz)
                    elif self.Psi[j][j]==6:
                        self.z[j] = calc3.Xi_7(self.z[j],zz)
                    elif self.Psi[j][j]==7:
                        self.z[j] = calc3.Xi_8(self.z[j],zz)
             
    #Procedure PsitoTexStr;
    def PsitoPasStr(self):
        for j in reversed(range(self.L)):
            self.zs[j] = "$z_{"+str(j)+"}="
            if self.Psi[j][j] == 2:
                self.zs[j] = self.zs[j]+"\text{Min}("
            elif self.Psi[j][j] == 3:
                self.zs[j] = self.zs[j]+"\text{Max}("
            elif self.Psi[j][j] == 4:
                self.zs[j] = self.zs[j]+"\text{Pol}("
            for i in reversed(range(self.L)):
                if self.Psi[i][j]!=0:
                    if self.Psi[i][j]!=1:
                        self.zs[j] = self.zs[j]+"\rho_{"+str(self.Psi[i][j])+"}(z_{"+str(i)+"})"
                    else:
                        self.zs[j] = self.zs[j]+"z_{"+str(i)+"}"
                    if self.Psi[j][j] == 0:
                        self.zs[j] = self.zs[j]+"+"
                    elif self.Psi[j][j] == 1:
                        self.zs[j] = self.zs[j]+"*"
            
            if (self.zs[j][len(self.zs[j])-1]=="+") or (self.zs[j][len(self.zs[j])-1]=="*"):
                self.zs[j][len(self.zs[j])-1] = ")"
            else:
                self.zs[j] = self.zs[J]+")"
            self.zs[j] = self.zs[j]+"$\\"
        for i in range(self.kP):
            self.zs[self.Pnum[i]] = "z_{"+str(self.Pnum[i])+"}=x_{"+str(i)+"}"
        for i in range(self.kR):
            self.zs[self.Pnum[i]] = "z_{"+str(self.Pnum[i])+"}=x_{"+str(i)+"}"
    
    #Procedure ReadPsi(var Psi1:TArrArrInt);
    def ReadPsi(self, Psi1):
        for i in range(self.L):
            for j in range(self.L):
                Psi1[i][j] = self.Psi[i][j]
        return Psi1
    
    #Procedure ReadPsi0(var Psi1:TArrArrInt);
    def ReadPsi0(self, Psi1):
        for i in range(self.L):
            for j in range(self.L):
                Psi1[i][j] = self.Psi0[i][j]
        return Psi1

class TGANOP(): 
    #PopChrStr:TArrArrArr4Int;//array for structural parts of chromosomes
    PopChrStr = []
    #PopChrPar:TArrArrInt;//array for perametrical parts of chromosomes
    PopChrPar = []
    #HH:integer;// number of cromosomes in initial population
    HH = 0
    #RR:integer;// number of couples in one generation
    RR = 0
    #PP:integer;// number of generations
    PP = 0
    #nfu:integer;//number of functionals
    nfu = 0
    #lchr:integer;//length of structural part of chromosome
    lchr = 0
    #Epo:integer;//number of generations between epochs
    Epo = 0
    #kel:integer;//number of elitared chromosomes
    kel = 0
    #Fuh:TArrArrReal;// values of functionals for each chromosome
    Fuh = []
    #Fuhminm:TArrArrReal;//minimai values on generation
    Fuhmimn = []
    #Lh:TArrInt;// values distance to Pareto set
    Lh = []
    #Pareto:TArrInt;// Pareto set
    Pareto = []
    #Son1s,Son2s,Son3s,Son4s:TArrArr4Int;//structural part of sons
    Son1s = []
    Son2s = []
    Son3s = []
    Son4s = []
    ##Son1p,Son2p,Son3p,Son4p:TArrInt;//parametrical part of sons
    Son1p = []
    Son2p = []
    Son3p = []
    Son4p = []
    #Lh1,Lh2,Lh3,Lh4:integer;//values distance to Pareto set for sons
    Lh1 = 0
    Lh2 = 0
    Lh3 = 0
    Lh4 = 0
    #Fuh1,Fuh2,Fuh3,Fuh4:TArrReal;// values of functionals for sons
    Fuh1 = []
    Fuh2 = []
    Fuh3 = []
    Fuh4 = []
    #FuhNorm:TArrArrReal;// values of normalized functionals for each chromosome
    FuhNorm = []
    #alfa:real;//parameter for select of parents
    alfa = 0
    #mut:real;//probability of mutation
    mut = 0
    #NOP:TNetOper;// Network operator
    #p:integer;//number of parameters
    p = 0
    #c:integer;// number of bit for integer part
    c = 0
    #d:integer;// number of bit for fractional part
    d = 0
    #q:TArrReal;//vector of parameters
    q = []
    #zb:TArrInt;//additional vector
    zb = []
    #ksearch:integer;// number of variants for parents
    ksearch = 1
    #flag_change:boolean;
    flag_change = True
    #ndGeneration:TProc;
    #Непонятка

    def __init__(self, hh1, pp1, rr1, nfu1, lchr1, p1, c1, d1, Epo1, kel1, alfa1, pmut1, Lay1, Mout1, kp1, kr1, kw1, kv1, ksearch1):
        self.HH = hh1;
        self.PP = pp1;
        self.RR = rr1;
        self.nfu = nfu1;
        self.lchr = lchr1;
        self.p = p1;
        self.c = c1;
        self.d = d1;
        self.Epo = Epo1;
        self.kel = kel1;
        self.alfa = alfa1;
        self.pmut = pmut1;
        self.ksearch = ksearch1;
        self.NOP = TNetOper(Lay1, Mout1, kp1, kr1, kw1, kv1);
        print("TGANOP created");
        self.PopChrStr = self.setlength3(self.PopChrStr,self.HH,self.lchr,4); #Увеличить размерность PopChrStr и детей
        self.PopChrPar = self.setlength2(self.PopChrPar,self.HH,self.p*(self.c+self.d));
        self.Fuh = self.setlength2(self.Fuh,self.HH,self.nfu);
        self.FuhNorm = self.setlength2(self.FuhNorm,self.HH,self.nfu);
        self.Lh = self.setlength1(self.Lh,self.HH);
        self.Fuh1 = self.setlength1(self.Fuh1,self.nfu);
        self.Fuh2 = self.setlength1(self.Fuh2,self.nfu);
        self.Fuh3 = self.setlength1(self.Fuh3,self.nfu);
        self.Fuh4 = self.setlength1(self.Fuh4,self.nfu);
        self.Son1s = self.setlength2(self.Son1s,self.lchr,4);
        self.Son2s = self.setlength2(self.Son2s,self.lchr,4);
        self.Son3s = self.setlength2(self.Son3s,self.lchr,4);
        self.Son4s = self.setlength2(self.Son4s,self.lchr,4);
        self.Son1p = self.setlength1(self.Son1p,self.p*(self.c+self.d));
        self.Son2p = self.setlength1(self.Son2p,self.p*(self.c+self.d));
        self.Son3p = self.setlength1(self.Son3p,self.p*(self.c+self.d));
        self.Son4p = self.setlength1(self.Son4p,self.p*(self.c+self.d));
        self.q = self.setlength1(self.q,self.p);
        self.zb = self.setlength1(self.zb,self.p*(self.c+self.d));
        


    def setlength1(self, List, Length):
        b = [];
        for i in range(Length):
            if len(List)-1>=i:
                b.append(List[i])
            else:
                b.append(0);
        return b;

    def setlength2(self, List, Lengt1, Lengt2):
        b = []
        for i in range(Lengt1):
            if len(List)-1>=i:
                b.append(List[i])
            else:
                b.append([]);
            for j in range(Lengt2):
                if len(List)-1>=i:
                    if len(List[i])>j:
                        b[i].append(List[i][j])
                else:
                    b[i].append(0);
        return b;

    def setlength3(self, List, Lengt1, Lengt2, Number):
        b = []
        for i in range(Lengt1):
            if len(List)-1>=i:
                b.append(List[i])
            else:
                b.append([]);
            for j in range(Lengt2):
                if len(List)-1>=i:
                    if len(List[i])>j:
                        b[i].append(List[i][j])
                else:
                    b[i].append([0,0,0,0]);
        return b;

    #Procedure ReadFunc(k:integer;var fFu1:TArrReal);
    def ReadFunc(self, k, fFu1):
        for i in range(self.nfu):
            fFu1[i] = self.Fuh[i]
        return fFu1;
    
    #Procedure Readq(var q1:TArrReal);
    def Readq(self, q1):
        for i in range(self.p):
            q1[i] = self.q[i]
        return q1

    #Procedure Setq(q1:TArrReal);
    def Setq(self,q1):
        for i in range(len(q1)):
            self.q[i] = q1[i]

    #Procedure SetPP(pp2:integer);
    def SetPP(self,pp2):
        self.PP = pp2;
        self.Fuhmimn = self.setlength2(self.Fuhmimn,self.nfu,self.PP)            

    #Procedure ChoosePareto;
    def ChoosePareto(self):
        j = 0;
        for i in range(self.HH):
            if self.Lh[i] == 0:
                j = j+1;
                self.Pareto = self.setlength1(self.Pareto,j);
                self.Pareto[j-1] = i;

    #Procedure Func0(var Fu:TArrReal); virtual;//Values of functionals
    def Func0(self, Fu):
        self.NOP.RPControl;
        for i in range(self.nfu):
            Fu[i] = self.NOP.z[self.NOP.Dnum[i]]
        return Fu
    
    #Procedure GreytoVector(y:TArrInt);
    def GreytoVector(self, y):
        l = self.c + self.d;
        lf1 = len(y);
        for i in range(lf1):
            if i % l == 0:
                self.zb[i] = y[i]
            else:
                self.zb[i] = self.zb[i-1] ^ y[i]
        j = -1;
        g1 = 1;
        g = 1;
        for i in range(self.c-1):
            g1 = g1*2
        for i in range(lf1):
            if i % l == 0:
                j = j+1;
                self.q[j] = 0;
                g = g1;
            self.q[j] = self.q[j]+g*self.zb[i];
            g = g/2;

    #Procedure VectortoGrey(var y: TArrInt);
    def VectortoGrey(self, y):
        for i in range(self.p*(self.c+self.d)):
            self.zb[i] = 0
        for j in range(self.p):
            x = int(self.q[j])
            r = self.q[j]-x;
            k = self.c+j*(self.c+self.d)-1;
            while k>=j*(self.c+self.d):
                self.zb[k] = x % 2;
                x = x // 2;
                k = k - 1;
            k = self.c+j*(self.c+self.d);
            while k<(self.c+self.d)*(j+1):
                r = 2*r;
                x = int(r);
                self.zb[k] = x;
                r = r-x;
                k = k+1;
            y[j*(self.c+self.d)] = self.zb[j*(self.c+self.d)];
            for i in range(j*(self.c+self.d)+1,(j+1)*(self.c+self.d)):
                y[i] = self.zb[i] ^ self.zb[i-1]

    #Function Rast(Fu:TArrReal):integer;//distance to Pareto set
    def rast(self, Fu):
        count = 0;
        for i in range(self.HH):
            j = 0;
            while (j<self.nfu) and (Fu[j]>=self.Fuh[i][j]):
                j = j+1;
            if j>=self.nfu:
                k = 0;
                while (k<self.nfu) and (Fu[k] == self.Fuh[i][k]):
                    k = k+1;
                if k<self.nfu:
                    count = count+1;
        return count

    #Procedure ReadChromosome(k:integer;var q1:TArrReal;var Psi1:TArrArrInt);
    def ReadChromosome(self, k, q1, Psi1):
        self.NOP.SetPsi(self.NOP.Psi0);
        for i in range(self.lchr):
            self.NOP.Variations(self.PopChrStr[k,i])
        self.GreytoVector(self.PopChrPar[k]);
        q1 = self.Readq(q1);
        Psi1 = self.NOP.ReadPsi(Psi1);
        return q1, Psi1
  
    #Procedure ImproveChrom(qq:TArrReal;var StrChrom: TArrArr4Int);  
    def ImproveChrom(self, qq, StrChrom):
        self.NOP.SetPsi(self.NOP.Psi0);
        self.Fuh1 = self.Func0(self.Fuh1);
        k = -1;
        for i in range(self.lchr):
            self.NOP.Variations(StrChrom[i]);
            self.Fuh2 = self.Func0(self.Fuh2);
            flag = True;
            for j in range(self.nfu):
                if self.Fuh2[j]>self.Fuh1[j]:
                    flag = False;
            if flag:
                for j in range(self.nfu):
                    self.Fuh1[j] = self.Fuh2[j];
                k = i;
        for i in range(k+1,self.lchr):
            for j in range(3):
                StrChrom[i][j] = 0;
        return StrChrom
    
    def GenAlgorithm(self):
        self.NOP.SetPsiBas(self.NOP.Psi);
        for i in range(24):
            print(ASNEE.NOP.Psi0[i]);
        Fuh = self.Func0(self.Fuh[0]);
        for i in range(2):
            print(Fuh[i]);
        print('---------------------------------------------------------------')

        #generating population
        self.NOP.SetPsiBas(self.NOP.Psi);
        self.VectortoGrey(self.PopChrPar[0]);
        for i in range(self.lchr):
            for j in range(4):
                self.PopChrStr[0][i][j] = 0;
        for i in range(1,self.HH):
            for j in range(self.lchr):
                self.PopChrStr[i][j] = self.NOP.GenVar(self.PopChrStr[i][j]);
            for j in range(self.p*(self.c+self.d)):
                self.PopChrPar[i][j] = random.choice([0,1]);
        #calculating values of functionals
        for i in range(self.HH): 
            self.NOP.SetPsi(self.NOP.Psi0);
            for j in range(self.lchr):
                self.NOP.Variations(self.PopChrStr[i][j])
            self.GreytoVector(self.PopChrPar[i]);
            if i == 20:
                a = 1;
            if i == 100:
                a = 1;
            if i == 200:
                a = 1;
            if i == 300:
                a = 1;
            if i == 400:
                a = 1;
            if i == 500:
                a = 1;
            if i == 511:
                a = 1;
            self.Fuh[i] = self.Func0(self.Fuh[i]);
       #calculating of distances to Pareto set
        for i in range(self.HH):
            self.Lh[i] = self.rast(self.Fuh[i]);
        #Start of cycle for generations
        pt = 1; #first current generation
        while True:
            #start of cycle for crossovering
            rt = 1; #first couple for crossoving
            while True:
                #select of two parents
                k1 = random.choice(range(self.HH));
                lhmin = self.Lh[k1];
                for i in range(self.ksearch):
                    ks1 = random.choice(range(self.HH));
                    if self.Lh[ks1]<lhmin:
                        k1 = ks1;
                        lhmin = self.Lh[ks1];
                k2 = random.choice(range(self.HH));
                ksi = random.choice([x * 0.1 for x in range(0, 10)]);#Проверить проверено
                if (ksi<(1+self.alfa*self.Lh[k1])/(1+self.Lh[k1])) or (ksi<(1+self.alfa*self.Lh[k2])/(1+self.Lh[k2])):
                    ks1 = random.choice(range(self.lchr));
                    ks2 = random.choice(range(self.p*(self.c+self.d)));
                    for i in range(self.lchr):
                        self.Son1s[i] = self.PopChrStr[k1][i];
                        self.Son2s[i] = self.PopChrStr[k2][i];
                    for i in range(ks2):
                        self.Son1p[i] = self.PopChrPar[k1][i];
                        self.Son2p[i] = self.PopChrPar[k2][i];
                        self.Son3p[i] = self.PopChrPar[k1][i];
                        self.Son4p[i] = self.PopChrPar[k2][i];
                    for i in range(ks2,self.p*(self.c+self.d)):
                        self.Son1p[i] = self.PopChrPar[k2][i];
                        self.Son2p[i] = self.PopChrPar[k1][i];
                        self.Son3p[i] = self.PopChrPar[k2][i];
                        self.Son4p[i] = self.PopChrPar[k1][i];
                    for i in range(ks1):
                        self.Son3s[i] = self.PopChrStr[k1][i];
                        self.Son4s[i] = self.PopChrStr[k2][i];
                    for i in range(ks1,self.lchr):
                        self.Son3s[i] = self.PopChrStr[k2][i];
                        self.Son4s[i] = self.PopChrStr[k1][i];
                    #Мутация 1
                    if random.choice([x * 0.1 for x in range(0, 10)])<self.pmut:
                        self.Son1p[random.choice(range(self.p*(self.c+self.d)))] = random.choice([0,1]);
                        index = random.choice(range(self.lchr));
                        self.Son1s[index] = self.NOP.GenVar(self.Son1s[index]);
                    self.NOP.SetPsi(self.NOP.Psi0);
                    for j in range(self.lchr):
                        self.NOP.Variations(self.Son1s[j]);
                    self.GreytoVector(self.Son1p);
                    self.Fuh1 = self.Func0(self.Fuh1);
                    self.Lh1 = self.rast(self.Fuh1);
                    Lmax = self.Lh[1];
                    imax = 1;
                    for i in range(2,self.HH):
                        if self.Lh[i]>Lmax:
                            Lmax = self.Lh[i];
                            imax = i;
                    if self.Lh1<Lmax:
                        for i in range(self.lchr):
                            self.PopChrStr[imax][i] = self.Son1s[i];
                        for i in range(self.p*(self.c+self.d)):
                            self.PopChrPar[imax][i] = self.Son1p[i];
                        for i in range(self.nfu):
                            self.Fuh[imax][i] = self.Fuh1[i];
                        for i in range(self.HH):
                            self.Lh[i] = self.rast(self.Fuh[i]);
                    #Мутация 2
                    if random.choice([x * 0.1 for x in range(0, 10)])<self.pmut:
                        self.Son2p[random.choice(range(self.p*(self.c+self.d)))] = random.choice([0,1]);
                        index = random.choice(range(self.lchr)); 
                        self.Son2s[index] = self.NOP.GenVar(self.Son2s[index]);
                    self.NOP.SetPsi(self.NOP.Psi0);
                    for j in range(self.lchr):
                        self.NOP.Variations(self.Son2s[j]);
                    self.GreytoVector(self.Son2p);
                    self.Fuh2 = self.Func0(self.Fuh2);
                    self.Lh2 = self.rast(self.Fuh2);
                    Lmax = self.Lh[1];
                    imax = 1;
                    for i in range(2,self.HH):
                        if self.Lh[i]>Lmax:
                            Lmax = self.Lh[i];
                            imax = i;
                    if self.Lh2<Lmax:
                        for i in range(self.lchr):
                            self.PopChrStr[imax][i] = self.Son2s[i];
                        for i in range(self.p*(self.c+self.d)):
                            self.PopChrPar[imax][i] = self.Son2p[i];
                        for i in range(self.nfu):
                            self.Fuh[imax][i] = self.Fuh2[i];
                        for i in range(self.HH):
                            self.Lh[i] = self.rast(self.Fuh[i]);
                    #Мутация 3
                    if random.choice([x * 0.1 for x in range(0, 10)])<self.pmut:
                        self.Son3p[random.choice(range(self.p*(self.c+self.d)))] = random.choice([0,1]);
                        index = random.choice(range(self.lchr));
                        self.Son3s[index] = self.NOP.GenVar(self.Son3s[index]);
                    self.NOP.SetPsi(self.NOP.Psi0);
                    for j in range(self.lchr):
                        self.NOP.Variations(self.Son3s[j]);
                    self.GreytoVector(self.Son3p);
                    self.Fuh3 = self.Func0(self.Fuh3);
                    self.Lh3 = self.rast(self.Fuh3);
                    Lmax = self.Lh[1];
                    imax = 1;
                    for i in range(2,self.HH):
                        if self.Lh[i]>Lmax:
                            Lmax = self.Lh[i];
                            imax = i;
                    if self.Lh3<Lmax:
                        for i in range(self.lchr):
                            self.PopChrStr[imax][i] = self.Son3s[i];
                        for i in range(self.p*(self.c+self.d)):
                            self.PopChrPar[imax][i] = self.Son3p[i];
                        for i in range(self.nfu):
                            self.Fuh[imax][i] = self.Fuh3[i];
                        for i in range(self.HH):
                            self.Lh[i] = self.rast(self.Fuh[i]);
                    #Мутация 4
                    if random.choice([x * 0.1 for x in range(0, 10)])<self.pmut:
                        self.Son4p[random.choice(range(self.p*(self.c+self.d)))] = random.choice([0,1]);
                        index = random.choice(range(self.lchr));
                        self.Son4s[index] = self.NOP.GenVar(self.Son4s[index]);
                    self.NOP.SetPsi(self.NOP.Psi0);
                    for j in range(self.lchr):
                        self.NOP.Variations(self.Son4s[j]);
                    self.GreytoVector(self.Son4p);
                    self.Fuh4 = self.Func0(self.Fuh4);
                    self.Lh4 = self.rast(self.Fuh4);
                    Lmax = self.Lh[1];
                    imax = 1;
                    for i in range(2,self.HH):
                        if self.Lh[i]>Lmax:
                            Lmax = self.Lh[i];
                            imax = i;
                    if self.Lh4<Lmax:
                        for i in range(self.lchr):
                            self.PopChrStr[imax][i] = self.Son4s[i];
                        for i in range(self.p*(self.c+self.d)):
                            self.PopChrPar[imax][i] = self.Son4p[i];
                        for i in range(self.nfu):
                            self.Fuh[imax][i] = self.Fuh4[i];
                        for i in range(self.HH):
                            self.Lh[i] = self.rast(self.Fuh[i]);
                rt = rt+1;
                if rt>=self.RR:
                    break;
            for i in range(self.nfu):
                su = self.Fuh[0][i];
                for j in range(self.HH):
                    if self.Fuh[j][i]<su:
                        su = self.Fuh[j][i];
                self.Fuhmimn[i][pt-1] = su;
            pt = pt+1;
            for i in range(self.HH):
                self.Lh[i] = self.rast(self.Fuh[i]);
            self.ChoosePareto();
            if pt % self.Epo == 0:
                self.flag_change = True;
                for i in range(self.nfu):
                    Fumax = self.Fuh[0][i];
                    Fumin = self.Fuh[0][i];
                    for k in range(self.HH):
                        if self.Fuh[k][i]>Fumax:
                            Fumax = self.Fuh[k][i];
                        else:
                            if self.Fuh[k][i]<Fumin:
                                Fumin = self.Fuh[k][i];
                    if abs(Fumax-Fumin)>1/(10**8):
                        for k in range(self.HH):
                            self.FuhNorm[k][i] = (self.Fuh[k][i]-Fumin)/(Fumax-Fumin);
                    else:
                        self.flag_change = False;
                if self.flag_change:
                    k = 0;
                    su = 0;
                    for i in range(self.nfu):
                        su = su+self.FuhNorm[0][i]*self.FuhNorm[0][i];
                    su = math.sqrt(su);
                    for i in range(1,self.HH):
                        su1 = 0;
                        for j in range(self.nfu):
                            su1 = su1+self.FuhNorm[i][j]*self.FuhNorm[i][j];
                        su1 = math.sqrt(su1);
                        if su1<su:
                            su=su1;
                            k = i;
                    self.NOP.SetPsi(self.NOP.Psi0);
                    for j in range(self.lchr):
                        self.NOP.Variations(self.PopChrStr[k][j]);                    
                    self.NOP.SetPsiBas(self.NOP.Psi);

                    
                    for i in range(self.lchr):
                        for j in range(0,3):
                            self.PopChrStr[0][i][j] = 0;
                    for i in range(self.p*(self.c+self.d)):
                        self.PopChrPar[0][i] = self.PopChrPar[k][i];

                    for i in range(24):
                        print(ASNEE.NOP.Psi0[i]);
                    Fuh = self.Func0(self.Fuh[0]);
                    for i in range(2):
                        print(Fuh[i]);
                    print('---------------------------------------------------------------')
                else:
                    for i in range(self.HH):
                        if self.Lh[i]!=0:
                            for j in range(self.lchr):
                                self.PopChrStr[i][j] = self.NOP.GenVar(self.PopChrStr[i][j]);
                            for j in range(self.p*(self.c+self.d)):
                                self.PopChrPar[i][j] = random.choice([0,1]);
                        else:
                            k1 = 0;
                            for j in range(i):
                                if self.Lh[j] == 0:
                                    su = 0;
                                    for k in range(self.nfu):
                                        su = su+abs(self.Fuh[i][k]-self.Fuh[j][k]);
                                    if su<0.001:
                                        for k in range(self.lchr):
                                            self.PopChrStr[i][k] = self.NOP.GenVar(self.PopChrStr[i][k]);
                                        for k in range(self.p*(self.c+self.d)):
                                            self.PopChrPar[i][k] = random.choice([0,1]);
                                        continue;
                for i in range(self.HH):
                    self.NOP.SetPsi(self.NOP.Psi0);
                    for j in range(self.lchr):
                        self.NOP.Variations(self.PopChrStr[i][j]);
                    self.GreytoVector(self.PopChrPar[i]);
                    self.Fuh[i] = self.Func0(self.Fuh[i]);
                for i in range(self.kel):
                    j = random.choice(range(self.HH-1))+1;
                    self.GreytoVector(self.PopChrPar[j]);
                    self.PopChrStr[j] = self.ImproveChrom(self.q,self.PopChrStr[j]);
                for i in range(self.HH):
                    self.Lh[i] = self.rast(self.Fuh[i]);
            if pt>=self.PP:
                break;        
        self.ChoosePareto();
class TModel(TGANOP):
    #x:TArrReal;// vector of condition
    x = [];
    #qy:TArrReal;//vextor of undefined parameters
    qy = [];
    #x0:TArrReal;// vector of initial condition
    x0 = [];
    #xs:TArrReal;//
    xs = [];
    #fb:TArrReal;
    fb = [];
    #fa:TArrReal;
    fa = [];
    #su:TArrReal;
    su = [];
    #su1:TArrReal;
    su1 = [];
    #u:TArrReal;// vector of control
    u = [];
    #umin:TArrReal;// vector of control
    umin = [];
    #umax:TArrReal;// vector of control
    umax = [];
    #y:TArrReal;// vector of vewing
    y = [];
    #n:integer;
    n = 0;
    #ny:integer;//dimention of undefined parameters
    ny = 0;
    #qymax,qymin:TArrReal;
    qymax = [];
    qymin = [];
    #ix,ixmax:TArrInt;
    ix = [];
    ixmax = [];
    #stepsqy:TArrReal;//vector of steps of undefine parameters
    stepsqy = [];
    #m:integer;
    m = 0;
    #lv:integer;
    lv = 0;
    #dt:real;
    dt = 0.0;
    #t:real;
    t = 0.0;
    #tf:real;
    tf = 0.0;
    #shtraf:real;
    shtraf = 0.0;

    def __init__(self,hh1,pp1,rr1,nfu1,lchr1,p1,c1,d1,Epo1,kel1,alfa1,pmut1,Lay1,Mout1,kp1,kr1,kw1,kv1,n1,m1,ll1,ny1, ksearch1):
        TGANOP.__init__(self,hh1,pp1,rr1,nfu1,lchr1,p1,c1,d1,Epo1,kel1,alfa1,pmut1,Lay1,Mout1,kp1,kr1,kw1,kv1,ksearch1);
        self.n = n1;
        self.m = m1;
        self.lv = ll1;
        self.ny = ny1;
        print("TModel created"); 
        self.x       = self.setlength1(self.x,self.n);
        self.x0      = self.setlength1(self.x0,self.n);
        self.xs      = self.setlength1(self.xs,self.n);
        self.fa      = self.setlength1(self.fa,self.n);
        self.fb      = self.setlength1(self.fb,self.n);
        self.u       = self.setlength1(self.u,self.m);
        self.umax    = self.setlength1(self.umax,self.m);
        self.umin    = self.setlength1(self.umin,self.m);
        self.qymin   = self.setlength1(self.qymin,self.ny);
        self.qymax   = self.setlength1(self.qymax,self.ny);
        self.qy      = self.setlength1(self.qy,self.ny);
        self.ixmax   = self.setlength1(self.ixmax,self.n);
        self.ix      = self.setlength1(self.ix,self.ny);
        self.stepsqy = self.setlength1(self.stepsqy,self.ny);
        self.y       = self.setlength1(self.y,self.lv);
        self.su      = self.setlength1(self.su,self.nfu);
        self.su1     = self.setlength1(self.su1,self.nfu);


    def setlength1(self, List, Length):
        b = [];
        for i in range(Length):
            if len(List)-1>=i:
                b.append(List[i])
            else:
                b.append(0);
        return b; 
   
    #Procedure Func(var Fu:TArrReal); virtual;
    def Func(self,Fu):
        for i in range(self.nfu):
            Fu[i] = 0;
        return Fu
    
    #Procedure LexPM(var ix1:tArrInt;var flag:boolean);
    def LexPM(self,ix1,flag):
        i = self.ny-1;
        while (i>=0) and (ix1[i] == self.ixmax[i]):
            i = i-1;
        if i>=0:
            ix1[i]=ix1[i]+1;
            for j in range(i+1,self.ny):
                ix1[j]=0;
            flag = True;
        else:
            flag = False;
        return ix1, flag

            

    #Procedure Integr; БОЛЬШОЙ ВОПРОС
    def Integr(self):
        flag = False;
        for i in range(self.ny):
            self.ix[i] = 0;
        for i in range(self.nfu):
            self.su[i] = 0;
        while True:
            for i in range(self.ny):
                self.qy[i] = self.qymin[i]+self.stepsqy[i]*self.ix[i];
            self.su1 = self.Func(self.su1);
            for i in range(self.nfu):
                self.su[i] = self.su[i]+self.su1[i];
            self.ix, flag = self.LexPM(self.ix,flag);
            if not flag:
                break;

    #Procedure Func0(var Fu:TArrReal); override;
    def Func0(self,Fu): #Учти, что Fu - это Fuh или Fuh1
        self.Integr();
        for i in range(self.nfu):
            Fu[i] = self.su[i];
        return Fu

    #Procedure Initial;virtual;
    def Initial(self):
        for i in range(self.n):
            self.x[i] = self.x0[i];
        self.t = 0;

    #Function OgrPhase:boolean;virtual;
    def OgrPhase(self):
        return True;
 
    #Procedure Upr;
    def Upr(self):
        self.u[0] = 1;
    
    #Procedure RP(t1:real;x1:TArrReal;var f1:TArrReal);virtual;//Правые части
    def RP(self,t1,x1,f1):
        TT=0.5;
        ksi = 0.09;
        ko = 1;
        self.Upr();
        f1[0] = self.x[1];
        f1[1] = -2*ksi*x[1]/TT+(ko*self.u[0]-self.x[0])/(TT*TT);
        for i in range(self.n):
            if abs(f1[i])>10**8:
                f1[i] = calc3.Ro_10(f1[i])*10**8;

    #Procedure Euler2;
    def Euler2(self):
        self.fa = self.RP(self.t,self.x,self.fa);
        for i in range(self.n):
            self.xs[i] = self.x[i]+self.dt*self.fa[i];
        self.fb = self.RP(self.t+self.dt,self.xs,self.fb);
        for i in range(self.n):
            self.x[i] = self.x[i]+self.dt*(self.fa[i]+self.fb[i])/2;
        self.t = self.t+self.dt;

    #Procedure Viewer;virtual;
    def Viewer(self):
        for i in range(self.n):
            self.y[i] = self.x[i];
  
    #Procedure OgrUpr;
    def OgrUpr(self):
        for i in range(self.m):
            if self.u[i]>self.umax[i]:
                self.u[i] = self.umax[i];
            else:
                if self.u[i]<self.umin[i]:
                    self.u[i] = self.umin[i];

    #Procedure Setdt(dt1:real);
    def Setdt(self,dt1):
        self.dt = dt1;

    #Procedure Setixmax(ix1:TArrInt);
    def Setixmax(self,ix1):
        for i in range(self.ny):
            self.ixmax[i] = ix1[i];

    #Procedure Setqymax(qymax1:TArrReal);
    def Setqymax(self, qymax1):
        for i in range(self.ny):
            self.qymax[i] = qymax1[i];

    #Procedure Setqymin(qymin1:TArrReal);
    def Setqymin(self, qymin1):
        for i in range(self.ny):
            self.qymin[i] = qymin1[i];

    #Procedure Setshtraf(s1:real);
    def Setshtraf(self,s1):
        self.shtraf = s1;

    #Procedure Setstepsqy(stepsqy1:TArrReal);
    def Setstepsqy(self,stepsqy1):
        for i in range(self.ny):
            self.stepsqy[i] = stepsqy1[i];

    #Procedure Setuogr(umin1,umax1:TArrReal);
    def Setuogr(self, umin1, umax1):
        for i in range(self.m):
            self.umin[i] = umin1[i];
            self.umax[i] = umax1[i];

    #Procedure Settf(tf1:real);
    def Settf(self,tf1):
        self.tf = tf1;

    #Procedure Setx0(x01:TArrReal);
    def Setx0(self, x01):
        for i in range(self.n):
            self.x0[i] = x01[i];  

class TUser(TModel):
    
    #Константы
    xf1 = [];
    epsterm = 0.1;

    def __init__(self,hh1,pp1,rr1,nfu1,lchr1,p1,c1,d1,Epo1,kel1,alfa1,pmut1,Lay1,Mout1,kp1,kr1,kw1,kv1,n1,m1,ll1,ny1,tf1,shtraf1,epstrem1,xf1, ksearch1):
        TModel.__init__(self,hh1,pp1,rr1,nfu1,lchr1,p1,c1,d1,Epo1,kel1,alfa1,pmut1,Lay1,Mout1,kp1,kr1,kw1,kv1,n1,m1,ll1,ny1,ksearch1);
        self.goalrun = 0;
        self.tf1 = tf1;
        self.shtraf = 2;
        self.epstrem = epstrem1;
        self.xf1 = xf1;

    def Normdist(self,x1,xf1):  
        sum = 0;
        for i in range(len(xf1)-1):
            aa = abs(xf1[i]-x1[i]);
            if aa>sum:
                sum = aa;
        return sum;

    def Viewer(self):
        self.y[0] = self.x[0];
        self.y[1] = self.x[1];
        self.y[2] = self.x[2];

    def Initial(self):
        self.x[0] = self.x0[0]+self.qy[0];
        self.x[1] = self.x0[1]+self.qy[1];
        self.x[2] = self.x0[2]+self.qy[2];
        self.u[0] = 0;
        self.u[1] = 0;
        self.t = 0;

    def Func(self, Fu):
        self.Initial();
        self.goalrun = self.goalrun+1;
        for i in range(self.NOP.kR):
            self.NOP.Cs[i] = self.q[i];
        while True:
            self.Viewer();
            self.Euler2();
            if (self.t>self.tf1) or (self.Normdist(self.x,self.xf1)<self.epsterm):
                break;
        promah = 0;
        for i in range(len(self.xf1)-1):
            promah = promah+(self.x[i]-self.xf1[i])*(self.x[i]-self.xf1[i]);
        promah = math.sqrt(promah);
        Fu[0] = self.t+self.shtraf*promah;
        Fu[1] = promah;
        return Fu;

    def RP(self,t1,x1,f1):
        alf = 0;
        self.NOP.Vs[0] = (self.xf1[0]-x1[0]);
        self.NOP.Vs[1] = (self.xf1[1]-x1[1]);
        self.NOP.Vs[2] = (self.xf1[2]-x1[2]);
        self.NOP.RPControl();
        if mycalc3.Normdist(x1,self.xf1)<self.epsterm:
            self.u[0] = 0;
            self.u[1] = 0;
        else:
            self.u[0] = self.NOP.z[self.NOP.Dnum[0]];
            self.u[1] = self.NOP.z[self.NOP.Dnum[1]];
        self.OgrUpr;
        f1[0] = 0.5*(self.u[0]+self.u[1])*math.cos(x1[2]);
        f1[1] = 0.5*(self.u[0]+self.u[1])*math.sin(x1[2]);
        f1[2] = 0.5*(self.u[0]-self.u[1]);
        for i in range(self.n):
            if abs(f1[i])>10**8:
                f1[i] = calc3.Ro_10(f1[i])*10**8;
        return f1;

    

# Писать отсюда



Psi1 = [[0,0,0,0,1,0,0,0,0,12],
        [0,0,0,0,0,1,1,0,0,0],
        [0,0,0,0,0,1,0,0,0,0],
        [0,0,0,0,0,0,3,0,0,0],
        [0,0,0,0,0,0,0,0,1,0],
        [0,0,0,0,0,1,0,1,0,0],
        [0,0,0,0,0,0,1,6,0,0],
        [0,0,0,0,0,0,0,1,1,0],
        [0,0,0,0,0,0,0,0,0,1],
        [0,0,0,0,0,0,0,0,0,0]];
#Переменные
x1 = 1;
x2 = 1;
q1 = 1;
q2 = 1;
#Параметры

#Lay1 = 10;
#Mout1 = 2;
Vs1 = [x1,x2];
Cs1 = [q1,q2];
#Pnum1 = [0,1];
#Rnum1 = [2,3];
#Dnum1 = [8,9];
#kP1 = 2;
#kR1 = 2;
#kW1 = 28;
#kV1 = 2;

#Пока не нужно
#O1s1 = [1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28];
#O2s1 = [1,2];

#Исполняемый код    
#a = TNetOper(Lay1,Mout1,kP1,kR1,kW1,kV1);
#a.SetVs(Vs1);
#a.SetCs(Cs1);
#a.SetO1s(O1s1);
#a.SetO2s(O2s1);
#a.SetPsi(Psi1);
#a.SetPnum(Pnum1);
#a.SetRnum(Rnum1);
#a.SetDnum(Dnum1);
#.RPControl();
#print(a.z);
#print('Ответ '+str(a.z[a.Dnum[0]]));

#b = TGANOP(10,10,10,2,4,2,4,8,10,10,10,0.5,Lay1,Mout1,kP1,kR1,kW1,kV1)

#q1 = [7.8, 10.3];
#b.Setq(q1);
#chislo = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
#b.VectortoGrey(chislo)
#b.GreytoVector(chislo)
#for i in range(len(chislo)):
#    print(chislo[i])
#print(b.q)

#b = TUser(10,10,10,2,4,2,4,8,10,10,10,0.5,Lay1,Mout1,kP1,kR1,kW1,kV1,2,2,2,2)

#b.NOP.SetVs(Vs1);
#b.NOP.SetCs(Cs1);
#b.NOP.SetO1s(O1s1);
#b.NOP.SetO2s(O2s1);
#b.NOP.SetPsi(Psi1);
#b.NOP.SetPnum(Pnum1);
#b.NOP.SetRnum(Rnum1);
#b.NOP.SetDnum(Dnum1);
#b.NOP.SetPsi(Psi1);
#b.NOP.SetPsiBas(Psi1);
#b.SetPP(10);
#b.GenAlgorithm();
#a = 1;
#b.NOP.RPControl();
#print(b.NOP.z);
#print('Ответ '+str(b.NOP.z[b.NOP.Dnum[0]]));


#Dimension of NOP
L1 = 24;
#Number of parameters
kr1 = 3;
#Number of variables
kp1 = 3;
#Number of functions with one argument
kw1 = 20;
#Number of functions with two arguments
kv1 = 2;
#Number of outputs
Mout1 = 2;
#Number of functionals
nfu1 = 2;
#Number of possible solutions in initial set, population
hh1 = 512; 
#hh1 = 10;
#Number of generations
pp1 = 128;
#pp1 = 10;
#Number of crossovers in one generation
rr1 = 128;
#rr1 = 10;
#Number of functionals
nfu1 = 2;
#Number of variations in one solution
lchr1 = 8;
#Number of requred parameters
p1 = 3;
#Number of bits for integer part of parameter
c1 = 4;
#Number of bits for a fractional part of parameter
d1 = 12;
#Number of generations in one epoch
epo1 = 10;
#epo1 = 2;
#Number of elite solution
kel1 = 10;
#kel1 = 2;
#Parameter for probability of crossover
alfa1 = 0.4;
#Probability of mutation
pmut1 = 0.7;
#Shtraf for phase constrains
Shtraf1 = 2;
#Weight for second functional
weight = 2.5;
#dimention of system;
n1=3;
#dimention of control;
m1=2;
#dimention of viewing;
ll1=3;
#step of integration;
dt1=0.01; 
#terminal time;
tf1=1.5;

x01 = [0,0,0];
xf1 = [0,0,0];
umin1 = [-10,-10];
umax1 = [10,10];
O1sc1 = [1,2,3,4, 5,6,7,8, 9,10,11,12, 13,14,15,16, 17,18,19,23];
O2sc1 = [1,2];
q1 = [1,1,1];
qymin1 = [-2.5,-2.5,-5*math.pi/12];
qymax1 = [2.5,2.5,5*math.pi/12];
stepsqy1 = [1.25,2.5,5*math.pi/12];
epsterm=0.1;
infinity=1**10;
Pnum1 = [0,1,2];
Rnum1 = [3,4,5];
Dnum1 = [22,23];
xmax1 = (7,7,math.pi/2);
xmin1 = (-7,-7,-math.pi/2);
tf1 = 1.5;
dt1 = 0.01;
ksearch1 = 8;
ny1 = 3;
ndu1 = 3;
#step of print;
#dtp:real=0.1;

Psi1 =   [[0,0,0,0,  0,0,1,0,	0,0,0,0,   0,0,0,0,  0,0,0,0,   0,0,0,0],
           [0,0,0,0,  0,0,0,1,  0,0,0,0,   0,0,0,0,  0,0,0,0,   0,0,0,0],
           [0,0,0,0,  0,0,0,0,  1,0,0,0,   0,0,0,0,  0,0,0,0,   0,0,0,0],
           [0,0,0,0,  0,0,1,0,  0,0,0,0,   0,0,0,0,  0,0,0,0,   0,0,0,0],

           [0,0,0,0,  0,0,0,1,  0,0,0,0,   0,0,0,0,  0,0,0,0,   0,0,0,0],
           [0,0,0,0,  0,0,0,0,  1,0,0,0,   0,0,0,0,  0,0,0,0,   0,0,0,0],
           [0,0,0,0,  0,0,2,0,  0,1,0,0,   0,0,0,0,  0,0,0,0,   0,0,0,0],
           [0,0,0,0,  0,0,0,2,  0,0,1,0,   0,0,0,0,  0,0,0,0,   0,0,0,0],

           [0,0,0,0,  0,0,0,0,  2,0,0,1,   0,0,0,0,  0,0,0,0,   0,0,0,0],
           [0,0,0,0,  0,0,0,0,  0,1,1,0,   0,0,0,0,  0,0,0,0,   0,0,0,0],
           [0,0,0,0,  0,0,0,0,  0,0,1,1,   0,0,0,0,  0,0,0,0,   0,0,0,0],
           [0,0,0,0,  0,0,0,0,  0,0,0,1,   1,0,0,0,  0,0,0,0,   0,0,0,0],

           [0,0,0,0,  0,0,0,0,  0,0,0,0,   1,1,0,0,  0,0,0,0,   0,0,0,0],
           [0,0,0,0,  0,0,0,0,  0,0,0,0,   0,1,1,0,  0,0,0,0,   0,0,0,0],
           [0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,1,1,  0,0,0,0,   0,0,0,0],
           [0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,1,  1,0,0,0,   0,0,0,0],

           [0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  1,1,0,0,   0,0,0,0],
           [0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,1,1,0,   0,0,0,0],
           [0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,0,1,1,   0,0,0,0],
           [0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,0,0,1,   1,0,0,0],

           [0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,0,0,0,   1,1,0,0],
           [0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,0,0,0,   0,1,1,0],
           [0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,0,0,0,   0,0,1,1],
           [0,0,0,0,  0,0,0,0,  0,0,0,0,   0,0,0,0,  0,0,0,0,   0,0,0,1]];



ASNEE = TUser(hh1, pp1, rr1, nfu1, lchr1, p1, c1, d1, epo1,kel1,alfa1, pmut1, L1, Mout1, kp1,kr1, kw1, kv1,n1,m1,ll1,ny1,tf1,Shtraf1, epsterm, xf1, ksearch1);
ASNEE.SetPP(pp1);
ASNEE.Setdt(dt1);
ASNEE.Settf(tf1);
ASNEE.Setx0(x01);
ASNEE.Setuogr(umin1,umax1);
ASNEE.Setqymin(qymin1);
ASNEE.Setqymax(qymax1);
ASNEE.Setstepsqy(stepsqy1);
for i in range(ASNEE.ny):
    ASNEE.ix[i] = int((ASNEE.qymax[i]-ASNEE.qymin[i])/ASNEE.stepsqy[i]);
ASNEE.Setixmax(ASNEE.ix);
ASNEE.Setq(q1);
ASNEE.NOP.SetRnum(Rnum1);
ASNEE.NOP.SetPnum(Pnum1);
ASNEE.NOP.SetDnum(Dnum1);
ASNEE.NOP.SetPsi(Psi1);
ASNEE.NOP.SetPsiBas(Psi1);
ASNEE.NOP.SetO1s(O1sc1);
ASNEE.NOP.SetO2s(O2sc1);
ASNEE.GenAlgorithm();
print('DONE');

#for i in range(24):
#    print(ASNEE.NOP.Psi[i]);
#print('--------------------------------')
#for i in range(24):
#    print(ASNEE.NOP.Psi0[i]);
    