#!/bin/bash
# Program: Basic Arithmetic Operations

# Input two numbers
read -p "Enter any number: " num1
read -p "Enter any number: " num2

# Perform operations
echo "$num1 + $num2 = $((num1 + num2)) (Addition)"
echo "$num1 - $num2 = $((num1 - num2)) (Subtraction)"
echo "$num1 * $num2 = $((num1 * num2)) (Multiplication)"
echo "$num1 / $num2 = $((num1 / num2)) (Division)"
echo "$num1 % $num2 = $((num1 % num2)) (Modulo)"
