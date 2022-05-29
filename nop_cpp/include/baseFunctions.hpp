#pragma once

#include <iostream>
#include <cmath>

namespace
{

	float ro_10(float inp);

	constexpr float Eps = pow(10, -8);
	constexpr size_t PokMax = 8; // what is it ????
	// todo try numeric_limits<float>::max()
	constexpr float Infinity = pow(10, 8);

	float ro_1(float inp)
	{
		return inp;
	}

	float ro_2(float inp)
	{
		if (abs(inp) > Infinity)
			return Infinity;
		else
			return sqrt(inp);  
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
			ro_10(inp)/Eps;
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
		return inp;
	}

	float ro_8(float inp)
	{
		return inp;
	}

	float ro_9(float inp)
	{
		return inp;
	}
	
	float ro_10(float inp)
	{
		return inp;
	}

	float ro_11(float inp)
	{
		return inp;
	}

	float ro_12(float inp)
	{
		return inp;
	}

	float ro_13(float inp)
	{
		return inp;
	}

	float ro_14(float inp)
	{
		return inp;
	}

	float ro_15(float inp)
	{
		return inp;
	}

	float ro_16(float inp)
	{
		return inp;
	}

	float ro_17(float inp)
	{
		return inp;
	}

	float ro_18(float inp)
	{
		return inp;
	}

	float ro_19(float inp)
	{
		return inp;
	}

	float ro_20(float inp)
	{
		return inp;
	}

	float ro_21(float inp)
	{
		return inp;
	}

	float ro_22(float inp)
	{
		return inp;
	}

	float ro_23(float inp)
	{
		return inp;
	}

	float ro_24(float inp)
	{
		return inp;
	}

	float ro_25(float inp)
	{
		return inp;
	}

	float ro_26(float inp)
	{
		return inp;
	}

	float ro_27(float inp)
	{
		return inp;
	}

	float ro_28(float inp)
	{
		return inp;
	}

} // namespace