def format_instructions(num_instructions, instructions):
    instructions_list = instructions.split()
    
    if len(instructions_list) != num_instructions:
        raise ValueError("Number of instructions doesn't match the input.")
    
    formatted_output = []
    for i, instruction in enumerate(instructions_list):
        hex_instruction = instruction[2:].zfill(8)  # Remove the '0x' prefix and zero-fill to 8 characters
        for j in range(3, -1, -1):  # Reversing the order
            formatted_output.append(f"memory_array[{i*4 + (3-j)}] = 8'h{hex_instruction[j*2:j*2+2]};")
    
    return '\n'.join(formatted_output)

if __name__ == "__main__":
    try:
        num_instructions = int(input("Enter the number: "))
        instructions = input("Enter the 32-bit hexadecimal instructions (space-separated): ")
        
        formatted_result = format_instructions(num_instructions, instructions)
        print(formatted_result)
    except ValueError as e:
        print("Error:", e)
