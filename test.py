import os
import subprocess

def check_file_extension(filename):
    _, file_extension = os.path.splitext(filename)
    return file_extension

def compile_cpp_file(filename):
    executable_name = filename.rsplit('.', 1)[0]
    # compilation_command = f"g++ -DDEBUG -std=c++20 -Wall -O2 -Wno-unused-result -Wno-sign-conversion -o {executable_name} {filename}"
    compilation_command = f"g++ -DDEBUG -std=c++20 -Wall -Wextra -pedantic -O2 -Wshadow -Wformat=2 -Wfloat-equal -Wshift-overflow -Wcast-qual -Wcast-align -D_GLIBCXX_DEBUG -D_GLIBCXX_DEBUG_PEDANTIC -fsanitize=address -fsanitize=undefined -fno-sanitize-recover -fstack-protector -o {executable_name} {filename}"
    return_code = subprocess.call(compilation_command, shell=True)
    return executable_name if return_code == 0 else None

def run_python_file(filename, input_file, output_file):
    os.system(f"python3 {filename} < {input_file} > {output_file}")

def run_java_file(filename, input_file, output_file):
    os.system(f"java {filename} < {input_file} > {output_file}")

def mark_differences(output_lines, expected_lines):
    marked_lines = []

    if len(output_lines) != len(expected_lines):
        marked_lines.append(">>> Output and Expected Output have different numbers of lines.")
        marked_lines.extend(output_lines)  # Display the entire output file
    else:
        for line_number, (output_line, expected_line) in enumerate(zip(output_lines, expected_lines), start=1):
            output_line = output_line.rstrip()
            expected_line = expected_line.rstrip()
            if output_line != expected_line:
                marked_lines.append(f"> {output_line}")
            else:
                marked_lines.append(output_line)
    return marked_lines

def check_tests():
    sol_file = "sol."  # Specify the name of your sol file without extension
    cpp_filename = sol_file + "cpp"
    py_filename = sol_file + "py"
    java_filename = sol_file + "java"

    if os.path.exists(cpp_filename):
        executable = compile_cpp_file(cpp_filename)
        if not executable:
            print("Compilation failed. Please check your C++ file.")
            return

        test_files = []
        for file in os.listdir('.'):
            if file.startswith('sol_') and file.endswith('.in'):
                input_file = file
                output_file = file.replace('sol_', 'ans_').replace('.in', '.out')
                test_files.append((input_file, output_file))

        if not test_files:
            print("No test files found in the directory.")
            return

        test_files = sorted(test_files)

        for i, (input_file, output_file) in enumerate(test_files, start=1):
            with open(input_file, 'r') as input_f:
                input_data = input_f.read().strip()

            expected_output_file = output_file  # Assume expected output has the same name as the output file
            expected_output = None
            with open(expected_output_file, 'r') as expected_output_f:
                expected_output = expected_output_f.read().strip()

            os.system(f"./{executable} < {input_file} > sol_{i}.out")

            output_data = None
            with open(f"sol_{i}.out", 'r') as output_f:
                output_data = output_f.read().rstrip()

            output_lines = [line[:-1] if line.endswith(' ') else line for line in output_data.split('\n')]
            expected_lines = [line[:-1] if line.endswith(' ') else line for line in expected_output.split('\n')]

            if output_lines == expected_lines:
                print(f"Test {i} Passed!")
            else:
                print(f"Test {i} Failed.")
                print("Xiao's Output:")
                print('\n'.join(mark_differences(output_data.split('\n'), expected_output.split('\n'))))
                print("-------------------")
                print("Expected Output:")
                print(expected_output)
            print()

        os.remove(executable)  # Clean up the executable file

    elif os.path.exists(py_filename):
        test_files = []
        for file in os.listdir('.'):
            if file.startswith('sol_') and file.endswith('.in'):
                input_file = file
                output_file = file.replace('sol_', 'ans_').replace('.in', '.out')
                test_files.append((input_file, output_file))

        if not test_files:
            print("No test files found in the directory.")
            return

        test_files = sorted(test_files)

        for i, (input_file, output_file) in enumerate(test_files, start=1):
            with open(input_file, 'r') as input_f:
                input_data = input_f.read().strip()

            expected_output_file = output_file  # Assume expected output has the same name as the output file
            expected_output = None
            with open(expected_output_file, 'r') as expected_output_f:
                expected_output = expected_output_f.read().strip()

            run_python_file(py_filename, input_file, f"sol_{i}.out")

            output_data = None
            with open(f"sol_{i}.out", 'r') as output_f:
                output_data = output_f.read().rstrip()

            output_lines = [line[:-1] if line.endswith(' ') else line for line in output_data.split('\n')]
            expected_lines = [line[:-1] if line.endswith(' ') else line for line in expected_output.split('\n')]

            if output_lines == expected_lines:
                print(f"Test {i} Passed!")
            else:
                print(f"Test {i} Failed.")
                print("Xiao's Output:")
                print('\n'.join(mark_differences(output_data.split('\n'), expected_output.split('\n'))))
                print("-------------------")
                print("Expected Output:")
                print(expected_output)
            print()
    elif os.path.exists(java_filename):
        test_files = []
        for file in os.listdir('.'):
            if file.startswith('sol_') and file.endswith('.in'):
                input_file = file
                output_file = file.replace('sol_', 'ans_').replace('.in', '.out')
                test_files.append((input_file, output_file))

        if not test_files:
            print("No test files found in the directory.")
            return

        test_files = sorted(test_files)

        for i, (input_file, output_file) in enumerate(test_files, start=1):
            with open(input_file, 'r') as input_f:
                input_data = input_f.read().strip()

            expected_output_file = output_file  # Assume expected output has the same name as the output file
            expected_output = None
            with open(expected_output_file, 'r') as expected_output_f:
                expected_output = expected_output_f.read().strip()

            run_java_file(java_filename, input_file, f"sol_{i}.out")

            output_data = None
            with open(f"sol_{i}.out", 'r') as output_f:
                output_data = output_f.read().rstrip()

            output_lines = [line[:-1] if line.endswith(' ') else line for line in output_data.split('\n')]
            expected_lines = [line[:-1] if line.endswith(' ') else line for line in expected_output.split('\n')]

            if output_lines == expected_lines:
                print(f"Test {i} Passed!")
            else:
                print(f"Test {i} Failed.")
                print("Xiao's Output:")
                print('\n'.join(mark_differences(output_data.split('\n'), expected_output.split('\n'))))
                print("-------------------")
                print("Expected Output:")
                print(expected_output)
            print()

    else:
        print(f"Unsupported sol file. Please provide either {cpp_filename} or {py_filename}.")

# Example usage:
check_tests()


