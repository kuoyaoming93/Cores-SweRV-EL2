bits = 12
combinations = 2**bits

f = open("inv.txt", "w")

for i in range(combinations):
    f.write("assign mem["+ str(i) + "] = "+ str(bits) +"'d" + str(combinations-1-i) + ";\n")
    print("assign mem["+ str(i) + "] = "+ str(bits) +"'d" + str(combinations-1-i) + ";")
1
f.close()