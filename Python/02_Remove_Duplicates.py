def remove_duplicates_loop(input_string):
    """
    Removes duplicate characters from a string using a loop.
    Preserves the original order of characters.
    """
   
    result = ""
    

    for char in input_string:
      
        if char not in result:
         
            result += char
            
    return result


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
