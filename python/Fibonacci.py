#! /usr/bin/env python
# -*- coding: utf-8 -*-
# Fibonacci
# Print the first 30 numbers of Successione di Fibonacci.


def fibonacci(number):                                            # Calculate Fibonacci number identifier with "number".
    if number == 1 or number == 2:                                # If it is the first or the second, the result is 1.
        return 1
    else:                                                         # If it isn't, the result is the sum of the last two
        return fibonacci(number - 1) + fibonacci(number - 2)      # Fibonacci number.

result = []                                                        # Define a variable "result" to save the result.
for i in range(1, 31):                                            # Calculate the first 30 numbers.
    result.append(fibonacci(i))
print result                                                      # Display result.
