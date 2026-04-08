def convert_to_readable_time(minutes):
    """
    Converts minutes into a human-readable string format.
    Example: 130 -> "2 hrs 10 minutes"
    """
    try:
        # Ensure input is integer
        minutes = int(minutes)
        
        if minutes < 0:
            return "Invalid input: Minutes cannot be negative."
        
        hours = minutes // 60
        remaining_minutes = minutes % 60
        
        # Build the string parts
        hour_part = ""
        if hours > 0:
            hour_part = f"{hours} hr" if hours == 1 else f"{hours} hrs"
            
        minute_part = ""
        if remaining_minutes > 0:
            minute_part = f"{remaining_minutes} minute" if remaining_minutes == 1 else f"{remaining_minutes} minutes"
            
        # Combine parts
        if hours > 0 and remaining_minutes > 0:
            return f"{hour_part} {minute_part}"
        elif hours > 0:
            return hour_part
        else:
            return minute_part

    except ValueError:
        return "Invalid input: Please enter a number."

# Driver Code for Testing
if __name__ == "__main__":
    test_cases = [130, 110, 60, 59, 1, 0]
    
    print("Time Conversion Results:")
    for t in test_cases:
        print(f"{t} minutes -> {convert_to_readable_time(t)}")