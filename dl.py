import os

def delete_files():

    sol_cpp = [file for file in os.listdir('.') if file.endswith('.cpp') and file.startswith('sol')]
    for file in sol_cpp:
        os.remove(file)

    sol_files = [file for file in os.listdir('.') if file.startswith('sol_')]
    for file in sol_files:
        os.remove(file)

    ans_files = [file for file in os.listdir('.') if file.startswith('ans_')]
    for file in ans_files:
        os.remove(file)

    out_files = [file for file in os.listdir('.') if file.endswith('.out')]
    for file in out_files:
        os.remove(file)

    int_files = [file for file in os.listdir('.') if file.endswith('.in')]
    for file in int_files:
        os.remove(file)

    print("Deleted all sol.cpp, sol{i}.out, sol{i}.in, and ans{i}.out files.")

# Example usage:
delete_files()
