import os

# First compile the source files
os.system("python3 gen.py > test.in")
os.system("g++ -DDEBUG -std=c++2a -Wall -O2 -Wno-unused-result -Wno-sign-conversion -o sol sol.cpp")
os.system("g++ -DDEBUG -std=c++2a -Wall -O2 -Wno-unused-result -Wno-sign-conversion -o bf bf.cpp")

# Start checking
while True:
	os.system("./sol < test.in > test.out")
	os.system("./bf < test.in > bf.out")
	if os.system("diff test.out bf.out"):
		print("WA")
		break
	else:
		print("AC")
		os.system("python3 gen.py > test.in")
