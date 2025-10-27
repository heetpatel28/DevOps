
# 50 Python Programs for Logic Building & Interviews

This guide contains a curated list of 50 Python programs designed to enhance your logic-building skills and prepare you for technical interviews. The problems range in difficulty and cover common patterns and data structures frequently encountered in coding rounds. Each problem includes a clear explanation of the logic, the complete code, and an example of its usage.

---

### Table of Contents

**String Manipulation**
1.  [Reverse a String](#program-1-reverse-a-string)
2.  [Check for Palindrome](#program-2-check-for-palindrome)
3.  [Find All Substrings](#program-3-find-all-substrings)
4.  [Count Vowels and Consonants](#program-4-count-vowels-and-consonants)
5.  [Check for Anagrams](#program-5-check-for-anagrams)
6.  [Find Longest Substring Without Repeating Characters](#program-6-find-longest-substring-without-repeating-characters)
7.  [Validate an IP Address](#program-7-validate-an-ip-address)
8.  [String to Integer (atoi)](#program-8-string-to-integer-atoi)
9.  [Group Anagrams](#program-9-group-anagrams)
10. [Find the First Non-Repeating Character](#program-10-find-the-first-non-repeating-character)

**Array & List Manipulation**

11. [Find the Missing Number in an Array](#program-11-find-the-missing-number-in-an-array)
12. [Find Duplicates in an Array](#program-12-find-duplicates-in-an-array)
13. [Rotate an Array to the Right](#program-13-rotate-an-array-to-the-right)
14. [Two Sum Problem](#program-14-two-sum-problem)
15. [Maximum Subarray Sum (Kadane's Algorithm)](#program-15-maximum-subarray-sum-kadanes-algorithm)
16. [Move Zeroes to the End](#program-16-move-zeroes-to-the-end)
17. [Merge Two Sorted Arrays](#program-17-merge-two-sorted-arrays)
18. [Product of Array Except Self](#program-18-product-of-array-except-self)
19. [Find the Kth Largest Element](#program-19-find-the-kth-largest-element)
20. [Container With Most Water](#program-20-container-with-most-water)

**Number & Mathematical Problems**

21. [Check for Prime Number](#program-21-check-for-prime-number)
22. [Generate Fibonacci Sequence](#program-22-generate-fibonacci-sequence)
23. [Calculate Factorial (Recursive)](#program-23-calculate-factorial-recursive)
24. [Greatest Common Divisor (GCD)](#program-24-greatest-common-divisor-gcd)
25. [Check for Armstrong Number](#program-25-check-for-armstrong-number)
26. [Power of a Number](#program-26-power-of-a-number)
27. [Reverse an Integer](#program-27-reverse-an-integer)
28. [Excel Column Number to Title](#program-28-excel-column-number-to-title)
29. [Check if a Number is a Power of Two](#program-29-check-if-a-number-is-a-power-of-two)
30. [FizzBuzz](#program-30-fizzbuzz)

**Recursion & Backtracking**

31. [Generate All Permutations of a List](#program-31-generate-all-permutations-of-a-list)
32. [Generate All Subsets (Power Set)](#program-32-generate-all-subsets-power-set)
33. [Letter Combinations of a Phone Number](#program-33-letter-combinations-of-a-phone-number)
34. [N-Queens Problem](#program-34-n-queens-problem)
35. [Sudoku Solver](#program-35-sudoku-solver)

**Data Structures & Algorithms**

36. [Implement Binary Search](#program-36-implement-binary-search)
37. [Implement a Stack using a List](#program-37-implement-a-stack-using-a-list)
38. [Implement a Queue using a List](#program-38-implement-a-queue-using-a-list)
39. [Check for Balanced Parentheses](#program-39-check-for-balanced-parentheses)
40. [Implement Bubble Sort](#program-40-implement-bubble-sort)
41. [Find the Intersection of Two Lists](#program-41-find-the-intersection-of-two-lists)
42. [Majority Element](#program-42-majority-element)
43. [Find Peak Element](#program-43-find-peak-element)
44. [Climbing Stairs](#program-44-climbing-stairs)
45. [Coin Change Problem](#program-45-coin-change-problem)

**DevOps & System-Related Problems**

46. [Find Most Frequent IP in a Log File](#program-46-find-most-frequent-ip-in-a-log-file)
47. [Validate a YAML/JSON Configuration](#program-47-validate-a-yamjson-configuration)
48. [Calculate File Checksum (SHA-256)](#program-48-calculate-file-checksum-sha-256)
49. [Find Large Files in a Directory](#program-49-find-large-files-in-a-directory)
50. [Compare Two Directory Trees](#program-50-compare-two-directory-trees)

---

## String Manipulation

<a name="program-1-reverse-a-string"></a>
### Program 1: Reverse a String
**Logic:** The simplest and most Pythonic way to reverse a string is to use slicing with a step of -1 (`[::-1]`). This creates a reversed copy of the string without modifying the original.

```python
def reverse_string(s):
    """
    Reverses a given string using slicing.
    """
    return s[::-1]

# Example
original = "hello world"
reversed_str = reverse_string(original)
print(f"Original: {original}")
print(f"Reversed: {reversed_str}")
```

<a name="program-2-check-for-palindrome"></a>
### Program 2: Check for Palindrome
**Logic:** A palindrome is a word that reads the same forwards and backwards. We can check this by comparing the original string with its reversed version. To make it case-insensitive, we first convert the string to lowercase.

```python
def is_palindrome(s):
    """
    Checks if a string is a palindrome (case-insensitive).
    """
    # Sanitize the string by converting to lowercase
    s_lower = s.lower()
    return s_lower == s_lower[::-1]

# Example
print(f"'Radar' is a palindrome: {is_palindrome('Radar')}")
print(f"'DevOps' is a palindrome: {is_palindrome('DevOps')}")
```

<a name="program-3-find-all-substrings"></a>
### Program 3: Find All Substrings
**Logic:** We can generate all substrings by using nested loops. The outer loop selects the starting character, and the inner loop selects the ending character. A list comprehension makes this concise.

```python
def find_all_substrings(s):
    """
    Generates all possible substrings of a given string.
    """
    n = len(s)
    substrings = [s[i:j] for i in range(n) for j in range(i + 1, n + 1)]
    return substrings

# Example
text = "abc"
print(f"All substrings of '{text}': {find_all_substrings(text)}")
```

<a name="program-4-count-vowels-and-consonants"></a>
### Program 4: Count Vowels and Consonants
**Logic:** Iterate through each character of the string (converted to lowercase for simplicity). Check if the character is in a predefined set of vowels. If it is, increment the vowel count. If it's an alphabet but not a vowel, increment the consonant count.

```python
def count_vowels_consonants(s):
    """
    Counts the number of vowels and consonants in a string.
    """
    vowels = "aeiou"
    vowel_count = 0
    consonant_count = 0
    
    for char in s.lower():
        if 'a' <= char <= 'z': # Check if it's an alphabet character
            if char in vowels:
                vowel_count += 1
            else:
                consonant_count += 1
                
    return vowel_count, consonant_count

# Example
text = "Hello DevOps World"
vowels, consonants = count_vowels_consonants(text)
print(f"In '{text}', Vowels: {vowels}, Consonants: {consonants}")
```

<a name="program-5-check-for-anagrams"></a>
### Program 5: Check for Anagrams
**Logic:** Two strings are anagrams if they contain the same characters with the same frequencies. The easiest way to check this is to sort both strings and see if they are identical.

```python
def are_anagrams(s1, s2):
    """
    Checks if two strings are anagrams of each other.
    """
    # Remove spaces and convert to lowercase for accurate comparison
    s1_cleaned = s1.replace(" ", "").lower()
    s2_cleaned = s2.replace(" ", "").lower()
    
    return sorted(s1_cleaned) == sorted(s2_cleaned)

# Example
print(f"'listen' and 'silent' are anagrams: {are_anagrams('listen', 'silent')}")
print(f"'hello' and 'world' are anagrams: {are_anagrams('hello', 'world')}")
```

<a name="program-6-find-longest-substring-without-repeating-characters"></a>
### Program 6: Find Longest Substring Without Repeating Characters
**Logic:** This is a classic "sliding window" problem. We maintain a window (a substring) and expand it by moving the right pointer. We use a set to keep track of characters in the current window. If we encounter a character that's already in the set, we shrink the window from the left until the duplicate is removed. We keep track of the maximum length found.

```python
def longest_substring_without_repeats(s):
    """
    Finds the length of the longest substring without repeating characters.
    """
    char_set = set()
    left = 0
    max_length = 0
    
    for right in range(len(s)):
        while s[right] in char_set:
            char_set.remove(s[left])
            left += 1
        char_set.add(s[right])
        max_length = max(max_length, right - left + 1)
        
    return max_length

# Example
text = "abcabcbb"
print(f"Longest substring length for '{text}': {longest_substring_without_repeats(text)}")
```

<a name="program-7-validate-an-ip-address"></a>
### Program 7: Validate an IP Address
**Logic:** An IPv4 address is valid if it has four octets separated by dots. Each octet must be a number between 0 and 255. We split the string by the dot and check if these conditions are met.

```python
def is_valid_ipv4(ip_str):
    """
    Validates if a given string is a valid IPv4 address.
    """
    parts = ip_str.split('.')
    
    if len(parts) != 4:
        return False
        
    for part in parts:
        if not part.isdigit():
            return False
        num = int(part)
        if not 0 <= num <= 255:
            return False
            
    return True

# Example
print(f"'192.168.1.1' is a valid IP: {is_valid_ipv4('192.168.1.1')}")
print(f"'256.0.0.1' is a valid IP: {is_valid_ipv4('256.0.0.1')}")
print(f"'192.168.1' is a valid IP: {is_valid_ipv4('192.168.1')}")
```

<a name="program-8-string-to-integer-atoi"></a>
### Program 8: String to Integer (atoi)
**Logic:** This function requires careful handling of edge cases. We first strip leading whitespace. Then we check for an optional sign (`+` or `-`). We then iterate through the subsequent characters, building the number until we hit a non-digit character. Finally, we apply the sign and clamp the result within the 32-bit signed integer range.

```python
def my_atoi(s):
    """
    Converts a string to a 32-bit signed integer.
    """
    s = s.strip()
    if not s:
        return 0
    
    sign = 1
    i = 0
    if s[0] == '-':
        sign = -1
        i += 1
    elif s[0] == '+':
        i += 1
        
    result = 0
    while i < len(s) and s[i].isdigit():
        result = result * 10 + int(s[i])
        i += 1
        
    result *= sign
    
    # Clamp to 32-bit integer range
    int_max = 2**31 - 1
    int_min = -2**31
    if result > int_max:
        return int_max
    if result < int_min:
        return int_min
        
    return result

# Example
print(f"atoi('   -42') -> {my_atoi('   -42')}")
print(f"atoi('4193 with words') -> {my_atoi('4193 with words')}")
```

<a name="program-9-group-anagrams"></a>
### Program 9: Group Anagrams
**Logic:** The key insight is that all anagrams become identical when their characters are sorted. We can use this sorted string as a key in a dictionary. We iterate through the list of words, sort each word to create a key, and append the original word to the list associated with that key in our dictionary.

```python
def group_anagrams(strs):
    """
    Groups a list of strings by anagrams.
    """
    anagram_map = {}
    for s in strs:
        sorted_s = "".join(sorted(s))
        if sorted_s not in anagram_map:
            anagram_map[sorted_s] = []
        anagram_map[sorted_s].append(s)
        
    return list(anagram_map.values())

# Example
words = ["eat", "tea", "tan", "ate", "nat", "bat"]
print(f"Grouped anagrams for {words}: {group_anagrams(words)}")
```

<a name="program-10-find-the-first-non-repeating-character"></a>
### Program 10: Find the First Non-Repeating Character
**Logic:** We can solve this in two passes. In the first pass, we iterate through the string and build a frequency map (a dictionary) of each character. In the second pass, we iterate through the string again and return the first character that has a count of 1 in our map.

```python
def first_non_repeating_char(s):
    """
    Finds the first non-repeating character in a string.
    """
    frequency = {}
    for char in s:
        frequency[char] = frequency.get(char, 0) + 1
        
    for char in s:
        if frequency[char] == 1:
            return char
            
    return None # Or an empty string, depending on requirements

# Example
text = "devopsv"
print(f"First non-repeating char in '{text}': {first_non_repeating_char(text)}")
```

---

## Array & List Manipulation

<a name="program-11-find-the-missing-number-in-an-array"></a>
### Program 11: Find the Missing Number in an Array
**Logic:** Given an array of `n` distinct numbers taken from `0, 1, ..., n`, find the one that is missing. The most efficient way is to use the mathematical formula for the sum of an arithmetic series. The expected sum is `n * (n + 1) / 2`. The actual sum is the sum of the numbers in the list. The difference between these two sums is the missing number.

```python
def find_missing_number(nums):
    """
    Finds the missing number in a sequence from 0 to n.
    """
    n = len(nums)
    expected_sum = n * (n + 1) // 2
    actual_sum = sum(nums)
    return expected_sum - actual_sum

# Example
arr = [3, 0, 1] # Sequence is 0, 1, 2, 3. Missing is 2.
print(f"Missing number in {arr}: {find_missing_number(arr)}")
```

<a name="program-12-find-duplicates-in-an-array"></a>
### Program 12: Find Duplicates in an Array
**Logic:** A simple and effective way is to use a set. We iterate through the array. For each number, if it's already in our set of seen numbers, it's a duplicate. If not, we add it to the set.

```python
def find_duplicates(nums):
    """
    Finds all duplicate numbers in a list.
    """
    seen = set()
    duplicates = set()
    for num in nums:
        if num in seen:
            duplicates.add(num)
        else:
            seen.add(num)
    return list(duplicates)

# Example
arr = [4, 3, 2, 7, 8, 2, 3, 1]
print(f"Duplicates in {arr}: {find_duplicates(arr)}")
```

<a name="program-13-rotate-an-array-to-the-right"></a>
### Program 13: Rotate an Array to the Right
**Logic:** To rotate an array `nums` to the right by `k` steps, we can use slicing. The last `k` elements become the new first `k` elements, and the first `n-k` elements become the new last `n-k` elements. We must handle cases where `k` is larger than the array length by using the modulo operator (`k % len(nums)`).

```python
def rotate_array(nums, k):
    """
    Rotates an array to the right by k steps.
    """
    n = len(nums)
    k = k % n # Handle cases where k > n
    
    # Slicing creates new lists, so we modify the original list in-place
    nums[:] = nums[-k:] + nums[:-k]
    return nums

# Example
arr = [1, 2, 3, 4, 5, 6, 7]
k = 3
print(f"Rotating {arr} by {k} gives: {rotate_array(arr, k)}")
```

<a name="program-14-two-sum-problem"></a>
### Program 14: Two Sum Problem
**Logic:** Given an array of integers and a target, find the indices of the two numbers that add up to the target. The optimal solution uses a hash map (dictionary). We iterate through the array. For each number `num`, we calculate the `complement` (`target - num`). If the `complement` is in our map, we have found our pair. If not, we add the current `num` and its index to the map.

```python
def two_sum(nums, target):
    """
    Finds indices of two numbers that sum to a target.
    """
    num_map = {} # val -> index
    for i, num in enumerate(nums):
        complement = target - num
        if complement in num_map:
            return [num_map[complement], i]
        num_map[num] = i
    return []

# Example
arr = [2, 7, 11, 15]
target = 9
print(f"Indices for target {target} in {arr}: {two_sum(arr, target)}")
```

<a name="program-15-maximum-subarray-sum-kadanes-algorithm"></a>
### Program 15: Maximum Subarray Sum (Kadane's Algorithm)
**Logic:** The goal is to find the contiguous subarray with the largest sum. Kadane's Algorithm is a dynamic programming approach. We maintain two variables: `max_so_far` and `current_max`. We iterate through the array, adding each element to `current_max`. If `current_max` becomes negative, we reset it to 0. At each step, we update `max_so_far` if `current_max` is greater.

```python
def max_subarray_sum(nums):
    """
    Finds the maximum sum of a contiguous subarray using Kadane's Algorithm.
    """
    max_so_far = float('-inf')
    current_max = 0
    
    for num in nums:
        current_max += num
        if current_max > max_so_far:
            max_so_far = current_max
        if current_max < 0:
            current_max = 0
            
    return max_so_far

# Example
arr = [-2, 1, -3, 4, -1, 2, 1, -5, 4]
print(f"Maximum subarray sum for {arr}: {max_subarray_sum(arr)}")
```

<a name="program-16-move-zeroes-to-the-end"></a>
### Program 16: Move Zeroes to the End
**Logic:** We can solve this using a two-pointer approach while maintaining the relative order of non-zero elements. One pointer (`write_ptr`) keeps track of the position where the next non-zero element should be placed. We iterate through the array with a `read_ptr`. If `nums[read_ptr]` is not zero, we place it at `nums[write_ptr]` and increment `write_ptr`. After the first pass, all non-zero elements are at the beginning. We then fill the rest of the array with zeroes.

```python
def move_zeroes(nums):
    """
    Moves all zeroes to the end of a list in-place.
    """
    write_ptr = 0
    for read_ptr in range(len(nums)):
        if nums[read_ptr] != 0:
            nums[write_ptr] = nums[read_ptr]
            write_ptr += 1
            
    for i in range(write_ptr, len(nums)):
        nums[i] = 0
    return nums

# Example
arr = [0, 1, 0, 3, 12]
print(f"Moving zeroes in {arr}: {move_zeroes(arr)}")
```

<a name="program-17-merge-two-sorted-arrays"></a>
### Program 17: Merge Two Sorted Arrays
**Logic:** The simplest way in Python is to concatenate the two lists and then sort the result. This leverages Python's highly optimized `sort()` method.

```python
def merge_sorted_arrays(arr1, arr2):
    """
    Merges two sorted arrays into a single sorted array.
    """
    merged = arr1 + arr2
    merged.sort()
    return merged

# Example
arr1 = [1, 2, 4]
arr2 = [1, 3, 4]
print(f"Merging {arr1} and {arr2}: {merge_sorted_arrays(arr1, arr2)}")
```

<a name="program-18-product-of-array-except-self"></a>
### Program 18: Product of Array Except Self
**Logic:** A clever approach is to solve this in two passes without using division. First, we create a `result` array. In the first pass, we iterate from left to right, where `result[i]` will be the product of all elements to the left of `i`. In the second pass, we iterate from right to left, multiplying `result[i]` by the product of all elements to the right of `i`.

```python
def product_except_self(nums):
    """
    Calculates the product of all elements in an array except the one at the current index.
    """
    n = len(nums)
    result = [1] * n
    
    # Pass 1: Calculate left products
    left_product = 1
    for i in range(n):
        result[i] = left_product
        left_product *= nums[i]
        
    # Pass 2: Calculate right products and multiply
    right_product = 1
    for i in range(n - 1, -1, -1):
        result[i] *= right_product
        right_product *= nums[i]
        
    return result

# Example
arr = [1, 2, 3, 4]
print(f"Product except self for {arr}: {product_except_self(arr)}")
```

<a name="program-19-find-the-kth-largest-element"></a>
### Program 19: Find the Kth Largest Element
**Logic:** The most straightforward way is to sort the array in descending order and then pick the element at index `k-1`.

```python
def find_kth_largest(nums, k):
    """
    Finds the kth largest element in an array.
    """
    nums.sort(reverse=True)
    return nums[k - 1]

# Example
arr = [3, 2, 1, 5, 6, 4]
k = 2
print(f"{k}nd largest element in {arr}: {find_kth_largest(arr, k)}")
```

<a name="program-20-container-with-most-water"></a>
### Program 20: Container With Most Water
**Logic:** This problem can be solved efficiently with a two-pointer approach. We start with one pointer at the beginning (`left`) and one at the end (`right`). The area is calculated as `min(height[left], height[right]) * (right - left)`. We then move the pointer that points to the shorter line inward, as moving the taller line's pointer can't possibly increase the area (since the width decreases and the height is limited by the shorter line).

```python
def max_area(height):
    """
    Finds the maximum area of water that can be contained between two lines.
    """
    max_area_val = 0
    left, right = 0, len(height) - 1
    
    while left < right:
        width = right - left
        current_height = min(height[left], height[right])
        max_area_val = max(max_area_val, width * current_height)
        
        if height[left] < height[right]:
            left += 1
        else:
            right -= 1
            
    return max_area_val

# Example
heights = [1, 8, 6, 2, 5, 4, 8, 3, 7]
print(f"Max area for {heights}: {max_area(heights)}")
```

---

## Number & Mathematical Problems

<a name="program-21-check-for-prime-number"></a>
### Program 21: Check for Prime Number
**Logic:** A prime number is a number greater than 1 that has no positive divisors other than 1 and itself. We can check this by iterating from 2 up to the square root of the number. If we find any number that divides it evenly, it's not prime. We only need to check up to the square root because if a number `n` has a divisor larger than its square root, it must also have a divisor smaller than it.

```python
import math

def is_prime(n):
    """
    Checks if a number is prime.
    """
    if n <= 1:
        return False
    for i in range(2, int(math.sqrt(n)) + 1):
        if n % i == 0:
            return False
    return True

# Example
print(f"Is 29 a prime number? {is_prime(29)}")
print(f"Is 15 a prime number? {is_prime(15)}")
```

<a name="program-22-generate-fibonacci-sequence"></a>
### Program 22: Generate Fibonacci Sequence
**Logic:** The Fibonacci sequence is a series where each number is the sum of the two preceding ones, starting from 0 and 1. We can generate it iteratively by keeping track of the last two numbers in the sequence and adding them to produce the next.

```python
def fibonacci_sequence(n_terms):
    """
    Generates the Fibonacci sequence up to n terms.
    """
    if n_terms <= 0:
        return []
    elif n_terms == 1:
        return [0]
        
    sequence = [0, 1]
    a, b = 0, 1
    while len(sequence) < n_terms:
        a, b = b, a + b
        sequence.append(b)
        
    return sequence

# Example
num_terms = 10
print(f"Fibonacci sequence for {num_terms} terms: {fibonacci_sequence(num_terms)}")
```

<a name="program-23-calculate-factorial-recursive"></a>
### Program 23: Calculate Factorial (Recursive)
**Logic:** The factorial of a non-negative integer `n` is the product of all positive integers up to `n`. This is a classic example of recursion. The base case is `factorial(0) = 1`. The recursive step is `factorial(n) = n * factorial(n - 1)`.

```python
def factorial(n):
    """
    Calculates the factorial of a number using recursion.
    """
    if n < 0:
        return "Factorial does not exist for negative numbers"
    elif n == 0:
        return 1
    else:
        return n * factorial(n - 1)

# Example
num = 5
print(f"Factorial of {num} is: {factorial(num)}")
```

<a name="program-24-greatest-common-divisor-gcd"></a>
### Program 24: Greatest Common Divisor (GCD)
**Logic:** The GCD of two integers is the largest positive integer that divides both of them without leaving a remainder. The Euclidean algorithm is a highly efficient method to find the GCD. It uses the principle that the GCD of two numbers does not change if the larger number is replaced by its difference with the smaller number. This can be implemented recursively: `gcd(a, b)` is `gcd(b, a % b)` until `b` is 0.

```python
def gcd(a, b):
    """
    Finds the Greatest Common Divisor of two numbers using the Euclidean algorithm.
    """
    while b:
        a, b = b, a % b
    return a

# Example
num1, num2 = 48, 18
print(f"GCD of {num1} and {num2} is: {gcd(num1, num2)}")
```

<a name="program-25-check-for-armstrong-number"></a>
### Program 25: Check for Armstrong Number
**Logic:** An Armstrong number (or narcissistic number) is a number that is equal to the sum of its own digits each raised to the power of the number of digits. For example, 153 is an Armstrong number because `1^3 + 5^3 + 3^3 = 1 + 125 + 27 = 153`.

```python
def is_armstrong_number(num):
    """
    Checks if a number is an Armstrong number.
    """
    s = str(num)
    n_digits = len(s)
    total = sum(int(digit)**n_digits for digit in s)
    return total == num

# Example
print(f"Is 153 an Armstrong number? {is_armstrong_number(153)}")
print(f"Is 123 an Armstrong number? {is_armstrong_number(123)}")
```

<a name="program-26-power-of-a-number"></a>
### Program 26: Power of a Number
**Logic:** A simple implementation can be done with a loop, multiplying the base by itself `exponent` times. A more Pythonic way is to use the `**` operator.

```python
def power(base, exp):
    """
    Calculates the power of a number.
    """
    return base ** exp

# Example
print(f"2 to the power of 5 is: {power(2, 5)}")
```

<a name="program-27-reverse-an-integer"></a>
### Program 27: Reverse an Integer
**Logic:** We can treat the integer as a string, reverse the string, and convert it back to an integer. We also need to handle the sign. If the original number is negative, we should make the reversed number negative as well.

```python
def reverse_integer(x):
    """
    Reverses an integer, handling the sign.
    """
    sign = -1 if x < 0 else 1
    s = str(abs(x))
    reversed_s = s[::-1]
    return sign * int(reversed_s)

# Example
print(f"Reverse of 123 is: {reverse_integer(123)}")
print(f"Reverse of -321 is: {reverse_integer(-321)}")
```

<a name="program-28-excel-column-number-to-title"></a>
### Program 28: Excel Column Number to Title
**Logic:** This is like converting a number from base-10 to base-26. We can repeatedly take the number modulo 26 to find the character for the current position and then update the number by integer division. A slight complication is that this system is 1-indexed (A=1), not 0-indexed, so we subtract 1 before each calculation.

```python
def excel_column_title(col_num):
    """
    Converts an Excel column number (1-based) to its corresponding title.
    """
    title = ""
    while col_num > 0:
        col_num, remainder = divmod(col_num - 1, 26)
        title = chr(65 + remainder) + title
    return title

# Example
print(f"Column 1 is: {excel_column_title(1)}")
print(f"Column 28 is: {excel_column_title(28)}")
print(f"Column 701 is: {excel_column_title(701)}")
```

<a name="program-29-check-if-a-number-is-a-power-of-two"></a>
### Program 29: Check if a Number is a Power of Two
**Logic:** A positive integer is a power of two if and only if it has exactly one bit set to 1 in its binary representation. A clever bitwise trick to check this is `n & (n - 1) == 0`. If `n` is a power of two (e.g., 8, which is `1000` in binary), `n-1` will have all bits below that set to 1 (e.g., 7, which is `0111`). The bitwise AND of these two numbers will always be 0.

```python
def is_power_of_two(n):
    """
    Checks if a number is a power of two using a bitwise trick.
    """
    if n <= 0:
        return False
    return (n & (n - 1)) == 0

# Example
print(f"Is 16 a power of two? {is_power_of_two(16)}")
print(f"Is 18 a power of two? {is_power_of_two(18)}")
```

<a name="program-30-fizzbuzz"></a>
### Program 30: FizzBuzz
**Logic:** A classic interview screening question. Iterate from 1 to `n`. For each number, check for divisibility. The key is to check for divisibility by 15 (`3 * 5`) first, then by 3, then by 5.

```python
def fizzbuzz(n):
    """
    Solves the FizzBuzz problem up to n.
    """
    result = []
    for i in range(1, n + 1):
        if i % 15 == 0:
            result.append("FizzBuzz")
        elif i % 3 == 0:
            result.append("Fizz")
        elif i % 5 == 0:
            result.append("Buzz")
        else:
            result.append(str(i))
    return result

# Example
print(f"FizzBuzz for n=15: {fizzbuzz(15)}")
```

---

## Recursion & Backtracking

<a name="program-31-generate-all-permutations-of-a-list"></a>
### Program 31: Generate All Permutations of a List
**Logic:** Backtracking is a great approach. The function explores all possible placements for each element. For each position, it tries placing every available number. After placing a number, it recursively calls itself to solve the rest of the permutation. After the recursive call returns, it "backtracks" by undoing the choice, allowing other numbers to be tried in that position.

```python
def permute(nums):
    """
    Generates all permutations of a list of numbers using backtracking.
    """
    def backtrack(start):
        if start == len(nums):
            result.append(nums[:])
            return
        
        for i in range(start, len(nums)):
            # Swap
            nums[start], nums[i] = nums[i], nums[start]
            # Recurse
            backtrack(start + 1)
            # Backtrack (swap back)
            nums[start], nums[i] = nums[i], nums[start]
            
    result = []
    backtrack(0)
    return result

# Example
arr = [1, 2, 3]
print(f"Permutations of {arr}: {permute(arr)}")
```

<a name="program-32-generate-all-subsets-power-set"></a>
### Program 32: Generate All Subsets (Power Set)
**Logic:** Another backtracking problem. For each element in the input list, we have two choices: either include it in the current subset or not. We can write a recursive helper function that builds a subset. In each call, we add the current subset to our results, then we iterate through the remaining elements, adding each one and making a recursive call, then backtracking by removing it.

```python
def subsets(nums):
    """
    Generates all possible subsets (the power set) of a list.
    """
    def backtrack(start, current_subset):
        result.append(current_subset[:])
        
        for i in range(start, len(nums)):
            current_subset.append(nums[i])
            backtrack(i + 1, current_subset)
            current_subset.pop()
            
    result = []
    backtrack(0, [])
    return result

# Example
arr = [1, 2, 3]
print(f"Subsets of {arr}: {subsets(arr)}")
```

<a name="program-33-letter-combinations-of-a-phone-number"></a>
### Program 33: Letter Combinations of a Phone Number
**Logic:** This is a classic backtracking problem. We map each digit to its corresponding letters. We then use a recursive function that builds a combination character by character. The function takes the index of the digit we are currently processing. For that digit, it loops through all its possible letters, appends each letter to the current combination, and makes a recursive call for the next digit.

```python
def letter_combinations(digits):
    """
    Generates all letter combinations for a given phone number string.
    """
    if not digits:
        return []
        
    phone_map = {
        '2': 'abc', '3': 'def', '4': 'ghi', '5': 'jkl',
        '6': 'mno', '7': 'pqrs', '8': 'tuv', '9': 'wxyz'
    }
    
    def backtrack(index, path):
        if len(path) == len(digits):
            result.append("".join(path))
            return
            
        possible_letters = phone_map[digits[index]]
        for letter in possible_letters:
            path.append(letter)
            backtrack(index + 1, path)
            path.pop()
            
    result = []
    backtrack(0, [])
    return result

# Example
digits = "23"
print(f"Letter combinations for '{digits}': {letter_combinations(digits)}")
```

<a name="program-34-n-queens-problem"></a>
### Program 34: N-Queens Problem
**Logic:** The problem is to place `N` queens on an `N`x`N` chessboard so that no two queens threaten each other. This is solved with backtracking. We try to place a queen in each row, one by one. For a given row, we iterate through all columns. If placing a queen in `(row, col)` is "safe" (i.e., not attacked by any previous queen), we place it and recursively call the function for the next row. If the recursive call fails to find a solution, we backtrack by removing the queen and trying the next column.

```python
def solve_n_queens(n):
    """
    Solves the N-Queens problem.
    """
    def is_safe(board, row, col):
        # Check column
        for i in range(row):
            if board[i][col] == 'Q':
                return False
        # Check upper-left diagonal
        for i, j in zip(range(row, -1, -1), range(col, -1, -1)):
            if board[i][j] == 'Q':
                return False
        # Check upper-right diagonal
        for i, j in zip(range(row, -1, -1), range(col, n)):
            if board[i][j] == 'Q':
                return False
        return True

    def backtrack(board, row):
        if row == n:
            solutions.append(["".join(r) for r in board])
            return
        
        for col in range(n):
            if is_safe(board, row, col):
                board[row][col] = 'Q'
                backtrack(board, row + 1)
                board[row][col] = '.' # Backtrack
    
    solutions = []
    empty_board = [['.' for _ in range(n)] for _ in range(n)]
    backtrack(empty_board, 0)
    return solutions

# Example
n = 4
print(f"Solutions for {n}-Queens: {solve_n_queens(n)}")
```

<a name="program-35-sudoku-solver"></a>
### Program 35: Sudoku Solver
**Logic:** This is another classic backtracking problem. We write a function that attempts to solve the board. It finds the first empty cell (`.`). It then tries placing each number from 1 to 9 in that cell. For each number, it checks if it's a valid placement (not already in the same row, column, or 3x3 subgrid). If it's valid, it places the number and makes a recursive call to solve the rest of the board. If the recursive call returns `True` (meaning a solution was found), we're done. If not, we backtrack by resetting the cell to `.` and try the next number.

```python
def solve_sudoku(board):
    """
    Solves a Sudoku puzzle using backtracking.
    """
    def is_valid(row, col, num):
        # Check row and column
        for i in range(9):
            if board[row][i] == num or board[i][col] == num:
                return False
        # Check 3x3 subgrid
        start_row, start_col = 3 * (row // 3), 3 * (col // 3)
        for i in range(start_row, start_row + 3):
            for j in range(start_col, start_col + 3):
                if board[i][j] == num:
                    return False
        return True

    def backtrack():
        for r in range(9):
            for c in range(9):
                if board[r][c] == '.':
                    for num_char in "123456789":
                        if is_valid(r, c, num_char):
                            board[r][c] = num_char
                            if backtrack():
                                return True
                            else:
                                board[r][c] = '.' # Backtrack
                    return False
        return True

    # Convert string numbers to a mutable list of lists
    board_list = [list(row) for row in board]
    backtrack()
    # Convert back to list of strings for the final result
    solved_board = ["".join(row) for row in board_list]
    return solved_board

# Example
puzzle = [
  "53..7....",
  "6..195...",
  ".98....6.",
  "8...6...3",
  "4..8.3..1",
  "7...2...6",
  ".6....28.",
  "...419..5",
  "....8..79"
]
print(f"Sudoku solution: {solve_sudoku(puzzle)}")
```
---

## Data Structures & Algorithms

<a name="program-36-implement-binary-search"></a>
### Program 36: Implement Binary Search
**Logic:** Binary search is an efficient algorithm for finding an item from a **sorted** list. It works by repeatedly dividing the search interval in half. We start with low and high pointers. We calculate the middle index. If the middle element is our target, we're done. If the target is smaller, we repeat the search on the left half; if larger, on the right half.

```python
def binary_search(sorted_list, target):
    """
    Implements binary search to find a target in a sorted list.
    """
    low, high = 0, len(sorted_list) - 1
    
    while low <= high:
        mid = (low + high) // 2
        if sorted_list[mid] == target:
            return mid
        elif sorted_list[mid] < target:
            low = mid + 1
        else:
            high = mid - 1
            
    return -1 # Target not found

# Example
arr = [2, 3, 4, 10, 40]
target = 10
print(f"Index of {target} in {arr}: {binary_search(arr, target)}")
```

<a name="program-37-implement-a-stack-using-a-list"></a>
### Program 37: Implement a Stack using a List
**Logic:** A stack is a Last-In, First-Out (LIFO) data structure. Python's list can be used to easily implement a stack. `append()` is used for `push`, and `pop()` (with no index) is used for `pop`.

```python
class Stack:
    def __init__(self):
        self.items = []

    def push(self, item):
        self.items.append(item)

    def pop(self):
        if not self.is_empty():
            return self.items.pop()
        return None

    def peek(self):
        if not self.is_empty():
            return self.items[-1]
        return None

    def is_empty(self):
        return len(self.items) == 0

# Example
s = Stack()
s.push('A')
s.push('B')
print(f"Popped item: {s.pop()}")
print(f"Top item: {s.peek()}")
```

<a name="program-38-implement-a-queue-using-a-list"></a>
### Program 38: Implement a Queue using a List
**Logic:** A queue is a First-In, First-Out (FIFO) data structure. While a list can be used, using `pop(0)` is inefficient for large lists. A better approach is to use `collections.deque`, which is optimized for appends and pops from both ends.

```python
from collections import deque

class Queue:
    def __init__(self):
        self.items = deque()

    def enqueue(self, item):
        self.items.append(item)

    def dequeue(self):
        if not self.is_empty():
            return self.items.popleft()
        return None

    def is_empty(self):
        return len(self.items) == 0

# Example
q = Queue()
q.enqueue('Job1')
q.enqueue('Job2')
print(f"Dequeued item: {q.dequeue()}")
```

<a name="program-39-check-for-balanced-parentheses"></a>
### Program 39: Check for Balanced Parentheses
**Logic:** This is a perfect use case for a stack. We iterate through the string. If we see an opening bracket `(`, `{`, `[`, we push it onto the stack. If we see a closing bracket, we check if the stack is empty or if the top of the stack is the corresponding opening bracket. If not, the string is unbalanced. At the end, if the stack is empty, the string is balanced.

```python
def are_parentheses_balanced(s):
    """
    Checks if a string has balanced parentheses using a stack.
    """
    stack = []
    mapping = {")": "(", "}": "{", "]": "["}
    
    for char in s:
        if char in mapping.values():
            stack.append(char)
        elif char in mapping.keys():
            if not stack or mapping[char] != stack.pop():
                return False
        else:
            continue
            
    return not stack

# Example
print(f"'()[]{{}}' is balanced: {are_parentheses_balanced('()[]{}')}")
print(f"'(]' is balanced: {are_parentheses_balanced('(]')}")
```

<a name="program-40-implement-bubble-sort"></a>
### Program 40: Implement Bubble Sort
**Logic:** Bubble Sort is a simple sorting algorithm that repeatedly steps through the list, compares adjacent elements, and swaps them if they are in the wrong order. The pass through the list is repeated until the list is sorted.

```python
def bubble_sort(nums):
    """
    Implements the Bubble Sort algorithm.
    """
    n = len(nums)
    for i in range(n):
        # Last i elements are already in place
        for j in range(0, n - i - 1):
            if nums[j] > nums[j + 1]:
                nums[j], nums[j + 1] = nums[j + 1], nums[j]
    return nums

# Example
arr = [64, 34, 25, 12, 22, 11, 90]
print(f"Sorted array: {bubble_sort(arr)}")
```

<a name="program-41-find-the-intersection-of-two-lists"></a>
### Program 41: Find the Intersection of Two Lists
**Logic:** The most efficient way to find the common elements between two lists is to convert them to sets and use the set intersection operator (`&`).

```python
def find_intersection(list1, list2):
    """
    Finds the intersection of two lists using sets.
    """
    set1 = set(list1)
    set2 = set(list2)
    return list(set1 & set2)

# Example
list1 = [1, 2, 2, 1]
list2 = [2, 2]
print(f"Intersection: {find_intersection(list1, list2)}")
```

<a name="program-42-majority-element"></a>
### Program 42: Majority Element
**Logic:** The majority element is the element that appears more than `n/2` times. The Boyer-Moore Voting Algorithm provides an efficient solution. We maintain a `candidate` and a `count`. We iterate through the list. If `count` is 0, we set the current element as the `candidate`. If the current element is the `candidate`, we increment `count`; otherwise, we decrement it.

```python
def majority_element(nums):
    """
    Finds the majority element using Boyer-Moore Voting Algorithm.
    """
    candidate = None
    count = 0
    for num in nums:
        if count == 0:
            candidate = num
        count += (1 if num == candidate else -1)
    return candidate

# Example
arr = [2, 2, 1, 1, 1, 2, 2]
print(f"Majority element: {majority_element(arr)}")
```

<a name="program-43-find-peak-element"></a>
### Program 43: Find Peak Element
**Logic:** A peak element is an element that is strictly greater than its neighbors. A binary search approach works well here. We compare the middle element `nums[mid]` with its right neighbor `nums[mid+1]`. If `nums[mid]` is smaller, then a peak must exist on the right side. Otherwise, a peak is on the left side (or `mid` itself is a peak).

```python
def find_peak_element(nums):
    """
    Finds a peak element in a list.
    """
    left, right = 0, len(nums) - 1
    while left < right:
        mid = (left + right) // 2
        if nums[mid] < nums[mid + 1]:
            left = mid + 1
        else:
            right = mid
    return left

# Example
arr = [1, 2, 1, 3, 5, 6, 4]
peak_index = find_peak_element(arr)
print(f"Peak element is at index {peak_index} with value {arr[peak_index]}")
```

<a name="program-44-climbing-stairs"></a>
### Program 44: Climbing Stairs
**Logic:** This is a classic dynamic programming problem that is identical to the Fibonacci sequence. To reach step `n`, you can either come from step `n-1` (by taking 1 step) or step `n-2` (by taking 2 steps). So, `ways(n) = ways(n-1) + ways(n-2)`. We can solve this iteratively to avoid recursion overhead.

```python
def climb_stairs(n):
    """
    Calculates the number of distinct ways to climb to the top of n stairs.
    """
    if n <= 2:
        return n
    one_step_before, two_steps_before = 2, 1
    for _ in range(3, n + 1):
        current = one_step_before + two_steps_before
        two_steps_before = one_step_before
        one_step_before = current
    return one_step_before

# Example
print(f"Ways to climb 4 stairs: {climb_stairs(4)}")
```

<a name="program-45-coin-change-problem"></a>
### Program 45: Coin Change Problem
**Logic:** Given a set of coin denominations and a total amount, find the fewest number of coins to make up that amount. This is a dynamic programming problem. We create an array `dp` where `dp[i]` is the minimum number of coins to make amount `i`. `dp[i] = min(dp[i], 1 + dp[i - coin])` for each coin.

```python
def coin_change(coins, amount):
    """
    Finds the fewest number of coins to make up an amount.
    """
    dp = [float('inf')] * (amount + 1)
    dp[0] = 0
    
    for i in range(1, amount + 1):
        for coin in coins:
            if i - coin >= 0:
                dp[i] = min(dp[i], 1 + dp[i - coin])
                
    return dp[amount] if dp[amount] != float('inf') else -1

# Example
coins = [1, 2, 5]
amount = 11
print(f"Minimum coins for amount {amount}: {coin_change(coins, amount)}")
```
---

## DevOps & System-Related Problems

<a name="program-46-find-most-frequent-ip-in-a-log-file"></a>
### Program 46: Find Most Frequent IP in a Log File
**Logic:** This script reads a log file, uses regular expressions to find all IP addresses, counts their occurrences using a dictionary or `collections.Counter`, and then finds the IP with the highest count.

```python
import re
from collections import Counter

def most_frequent_ip(log_file_path):
    """
    Parses a log file and finds the most frequent IP address.
    """
    ip_pattern = r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}'
    try:
        with open(log_file_path, 'r') as f:
            log_content = f.read()
            ip_addresses = re.findall(ip_pattern, log_content)
            if not ip_addresses:
                return "No IP addresses found."
            ip_counter = Counter(ip_addresses)
            most_common = ip_counter.most_common(1)[0]
            return most_common
    except FileNotFoundError:
        return f"Error: File not found at {log_file_path}"

# Create a dummy log file for the example
with open("sample.log", "w") as f:
    f.write("192.168.1.1 - - [..] GET /home\n")
    f.write("10.0.0.1 - - [..] POST /login\n")
    f.write("192.168.1.1 - - [..] GET /about\n")
    f.write("192.168.1.1 - - [..] GET /contact\n")

# Example
print(f"Most frequent IP: {most_frequent_ip('sample.log')}")
```

<a name="program-47-validate-a-yamjson-configuration"></a>
### Program 47: Validate a YAML/JSON Configuration
**Logic:** In DevOps, you often need to ensure a configuration file contains all the required keys. This function takes a configuration dictionary and a list of required keys, returning any that are missing.

```python
import yaml # Requires PyYAML: pip install pyyaml

def validate_config(config_dict, required_keys):
    """
    Validates that a dictionary contains a set of required keys.
    """
    missing_keys = [key for key in required_keys if key not in config_dict]
    return missing_keys

# Create a dummy config file
config_content = """
database:
  host: localhost
  port: 5432
server:
  host: 0.0.0.0
# 'port' is missing under server
"""
config_data = yaml.safe_load(config_content)

# Example
required_server_keys = ["host", "port"]
missing = validate_config(config_data.get("server", {}), required_server_keys)
if missing:
    print(f"Validation failed. Missing server keys: {missing}")
else:
    print("Server configuration is valid.")
```

<a name="program-48-calculate-file-checksum-sha-256"></a>
### Program 48: Calculate File Checksum (SHA-256)
**Logic:** Calculating a file's checksum is essential for verifying its integrity. This script reads a file in binary chunks (to handle large files efficiently) and updates a `hashlib.sha256` object with each chunk.

```python
import hashlib

def get_file_sha256(file_path):
    """
    Calculates the SHA-256 checksum of a file.
    """
    sha256_hash = hashlib.sha256()
    try:
        with open(file_path, "rb") as f:
            # Read and update hash in chunks of 4K
            for byte_block in iter(lambda: f.read(4096), b""):
                sha256_hash.update(byte_block)
        return sha256_hash.hexdigest()
    except FileNotFoundError:
        return "Error: File not found."

# Create a dummy file
with open("data.txt", "w") as f:
    f.write("This is a test file for checksum calculation.")

# Example
checksum = get_file_sha256("data.txt")
print(f"SHA-256 Checksum for data.txt: {checksum}")
```

<a name="program-49-find-large-files-in-a-directory"></a>
### Program 49: Find Large Files in a Directory
**Logic:** This script uses the `os` module to walk through a directory tree. For each file, it checks its size using `os.path.getsize` and prints the path if it exceeds a given threshold.

```python
import os

def find_large_files(directory, size_in_mb):
    """
    Finds files in a directory larger than a specified size.
    """
    threshold_bytes = size_in_mb * 1024 * 1024
    large_files = []
    for dirpath, _, filenames in os.walk(directory):
        for filename in filenames:
            file_path = os.path.join(dirpath, filename)
            if os.path.getsize(file_path) > threshold_bytes:
                large_files.append(file_path)
    return large_files

# Example (this will search the current directory '.')
print(f"Large files (>1MB) in current dir: {find_large_files('.', 1)}")
```

<a name="program-50-compare-two-directory-trees"></a>
### Program 50: Compare Two Directory Trees
**Logic:** This script can be used to verify if a backup or deployment was successful. It gets a list of all files in two directories and then uses sets to find files that are unique to each, indicating differences.

```python
import os

def compare_directories(dir1, dir2):
    """
    Compares two directories and finds files that are not in common.
    """
    def get_relative_paths(root_dir):
        paths = set()
        for dirpath, _, filenames in os.walk(root_dir):
            for filename in filenames:
                full_path = os.path.join(dirpath, filename)
                relative_path = os.path.relpath(full_path, root_dir)
                paths.add(relative_path)
        return paths

    files1 = get_relative_paths(dir1)
    files2 = get_relative_paths(dir2)

    only_in_dir1 = files1 - files2
    only_in_dir2 = files2 - files1

    return only_in_dir1, only_in_dir2

# Create dummy directories and files for example
os.makedirs("source/subdir", exist_ok=True)
os.makedirs("dest/subdir", exist_ok=True)
with open("source/file1.txt", "w") as f: f.write("a")
with open("source/subdir/file2.txt", "w") as f: f.write("b")
with open("dest/file1.txt", "w") as f: f.write("a")
with open("dest/file3.txt", "w") as f: f.write("c")

# Example
only1, only2 = compare_directories("source", "dest")
print(f"Files only in 'source': {only1}")
print(f"Files only in 'dest': {only2}")
```