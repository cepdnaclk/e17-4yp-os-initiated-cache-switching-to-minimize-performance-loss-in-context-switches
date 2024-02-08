def reverse_and_print_pairs(input_string):
    # Split the input string into pairs of two characters
    pairs = [input_string[i:i+2] for i in range(0, len(input_string), 2)]

    # Reverse the order of the pairs and print each pair on a new line
    for pair in reversed(pairs):
        print(pair)

# Take input line by line
input_lines = []
while True:
    try:
        line = input()
        if not line:
            break
        input_lines.append(line)
    except EOFError:
        break

# Process each line and print the output
for line in input_lines:
    reverse_and_print_pairs(line)
