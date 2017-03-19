#! /usr/bin/env python
# -*- coding: utf-8 -*-
# PrimeNumber.py
# Print all the Numbers smaller than 10,000.
import math


def isPrime(number):                                   # Definition of function :
                                                        # Examine if "number" is a prime number.
    for i in range(2, int(math.sqrt(number) + 1)):     # Try to make "number" divided exactly by numbers smaller than
        if number % i == 0:                            # it's square root.If we make it, return FAlSE.
            return False
    return True

result = []                                             # Define a variable "result" to save the result.
for j in range(2, 10001):                              # Examine numbers range from 1 to 10,000.
    if isPrime(j):
        result.append(j)
print result                                           # Display result.
