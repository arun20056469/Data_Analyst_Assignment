def remove_duplicates_loop(input_string):
    """
    Removes duplicate characters from a string using a loop.
    Preserves the original order of characters.
    """
    # Initialize an empty string to store the result
    result = ""
    
    # Loop through every character in the input string
    for char in input_string:
        # Check if the character is NOT already in the result string
        if char not in result:
            # Append it to the result
            result += char
            
    return result

# Driver Code for Testing
if __name__ == "__main__":
    inputs = [
        "programming",
        "hello world",
        "aabbccdd",
        "PlatinumRx"
    ]
    
    print("Duplicate Removal Results:")
    for s in inputs:
        print(f"Original: '{s}' -> Unique: '{remove_duplicates_loop(s)}'")