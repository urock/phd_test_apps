#include "baseFunctions.hpp"

float ro_1(float inp)
{
	return inp;
}

float ro_2(float inp)
{
	if (abs(inp) > sqrt(Infinity))
		return Infinity;
	else
		return pow(inp, 2);  
}

float ro_3(float inp)
{
	return (-1) * inp;
}

float ro_4(float inp)
{
	return ro_10(inp) * sqrt(abs(inp));
}

float ro_5(float inp)
{
	if (abs(inp) > Eps)
		return 1./inp;
	else
		return ro_10(inp)/Eps;
}

float ro_6(float inp)
{
	if (inp > -log(Eps))
		return -log(Eps);
	else
		return exp(inp);
}

float ro_7(float inp)
{
	if (abs(inp) < exp(-PokMax))
		return log(Eps);
	else
		return log(abs(inp));
}

float ro_8(float inp)
{
	if (abs(inp) > -log(Eps))
		return ro_10(inp);
	else
		return (1-exp(-inp))/(1+exp(-inp));
}

float ro_9(float inp)
{
	if (inp >= 0)
		return 1.;
	else
		return 0.;
}

float ro_10(float inp)
{
	if (inp >= 0.)
		return 1.;
	else
		return -1.;
}

float ro_11(float inp)
{
	return cos(inp);
}

float ro_12(float inp)
{
	return sin(inp);
}

float ro_13(float inp)
{
	return atan(inp);
}

float ro_14(float inp)
{
	if (abs(inp) > ro_15(Infinity))
		return ro_10(inp) * Infinity;
	else
		return pow(inp, 3); // sqr(z)*z
}

float ro_15(float inp)
{
	if (abs(inp) < Eps)
		return ro_10(inp) * Eps;
	else
		return ro_10(inp) * exp(log(abs(inp))/3.);
}

float ro_16(float inp)
{
	if (abs(inp)<1)
		return inp;
	else
		return ro_10(inp);
}

float ro_17(float inp)
{
	return ro_10(inp) * log(abs(inp) + 1);
}

float ro_18(float inp)
{
	if (abs(inp) > -log(Eps))
		return ro_10(inp) * Infinity;
	else
		return ro_10(inp) * (exp(abs(inp)) - 1);
}

float ro_19(float inp)
{
	if (abs(inp) > 1./Eps)
		return ro_10(inp) * Eps;
	else
		return ro_10(inp) * exp(-abs(inp));
}

float ro_20(float inp)
{
	return inp / 2.;
}

float ro_21(float inp)
{
	return inp * 2.;
}

float ro_22(float inp)
{
	if (inp < 0)
		return exp(inp) - 1;
	else
		return 1 - exp(-abs(inp));
}

float ro_23(float inp)
{
	if (abs(inp) > 1./Eps)
		return (-1) * ro_10(inp) / Eps;
	else
		return inp - inp * pow(inp, 3);
}

float ro_24(float inp)
{
	if (inp > Infinity)
		return 1;
	else
		return 1. / (1. + exp(-inp));
}

float ro_25(float inp)
{
	if (inp > 0)
		return 1;
	else
		return 0;
}

float ro_26(float inp)
{
	if (abs(inp) < pow(10, -2))
		return 0.;
	else 
		return ro_10(inp);
}

float ro_27(float inp)
{
	if (abs(inp) > 1)
		return ro_10(inp);
	else
		return ro_10(inp) * (1 - sqrt(1 - pow(inp, 2)));
}

float ro_28(float inp)
{
	if (pow(inp, 2) > log(Infinity))
		return inp * (1 - Eps);
	else
		return inp * (1 - exp(-pow(inp, 2)));
}

float xi_1(float l, float r)
{
	return l + r;
}

float xi_2(float l, float r)
{
	if (abs(l * r) > Infinity)
		return ro_10(l * r) * Infinity;
	else
		return l * r;
}

float xi_3(float l, float r)
{
	if (l >= r)
		return l;
	else
		return r;
}

float xi_4(float l, float r)
{
	if (l < r)
		return l;
	else
		return r;
}

float xi_5(float l, float r)
{
	return l + r - l * r;
}

float xi_6(float l, float r)
{
	return ro_10(l + r) * sqrt(pow(l, 2) + pow(r, 2));
}

float xi_7(float l, float r)
{
	return ro_10(l + r) * (abs(l) + abs(r));
}

float xi_8(float l, float r)
{
	return ro_10(l + r) * xi_2(abs(l), abs(2));
}
