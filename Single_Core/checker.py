from os import makedirs


f = open("F:/Single_Core/Single_Core/simulation/modelsim/output_data.mem", "r")
data = (f.readlines())
data = data[3:]

for i in range (0, len(data)):
    data[i] = data[i].split(" ")


data_new=[]
for i in range(0,len(data)):
    row_new=[]
    for j in range(0,len(data[i])):
        if (data[i][j]!=''):
            if '\n' in data[i][j]:
                data[i][j]=data[i][j][0:-1]
            if ':' in data[i][j]:
                continue
            row_new.append(data[i][j])
    data_new = data_new + row_new

data = (data_new[0:-1])
#print (data)

matrix_size = int(data[0])
matrix_A = data[2:258]
matrix_B = data[258:514]
matrix_O = data[514:1026]

#print(matrix_O)

for i in range(0,2*(matrix_size**2),2):
    k=(bin(int(matrix_O[i])).replace("0b", "")).zfill(8)
    j=(bin(int(matrix_O[i+1])).replace("0b", ""))
    t =j+k
    #print(t,int(t,2))

    if (i % (2*matrix_size)==0):
        print("\n")
        print(int(t,2), end = " ")
    else:
        print(int(t,2), end = " ")

    
 

    



