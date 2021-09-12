from os import makedirs
import math

cores = 4;

f = open("C:/Users/Vinith Kugathasan/OneDrive/Desktop/Rectangular Core/N Core/simulation/modelsim/output_data.mem", "r")
#f = open("C:/Users/Vinith Kugathasan/OneDrive/Desktop/Multi-core/Single_Core/simulation/modelsim/output_data.mem", "r")
#f = open("C:/Users/Vinith Kugathasan/OneDrive/Desktop/one_core_complete/Single_Core/simulation/modelsim/output_data.mem", "r")
#f = open("C:/Users/Vinith Kugathasan/OneDrive/Desktop/output_data.mem", "r")
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

#print(int(data[0]))
matrix_size = (bin(int(data[0])).replace("0b", "")).zfill(8*cores)
column_size = (bin(int(data[3])).replace("0b", "")).zfill(8*cores)

matrix_size = int(matrix_size[0:8],2)
column_size = int(column_size[0:8],2)
#matrix_size += matrix_size%cores
#print(matrix_size)

# matrix_A = data[2:258]
# matrix_B = data[258:514]
matrix_O = data[516:]
#print(matrix_O)

row_size = cores*math.ceil(matrix_size/cores)
#print(row_size)


m = int(row_size*column_size*2/cores)

print(m)
#print(m)
values=[]
#print(m)
for i in range(0,m,2):
    k=(bin(int(matrix_O[i])).replace("0b", "")).zfill(8*cores)
    j=(bin(int(matrix_O[i+1])).replace("0b", "")).zfill(8*cores)
    #print(k,j)

    for l in range(0,cores):
        num = j[8*l:8*(l+1)]+ k[8*l:8*(l+1)]
        values.append(int(num,2))

#print(values)

import numpy as np
matrix_list = np.zeros((row_size,column_size))

for j in range(0,len(values)): 
    matrix_list[j%row_size, j//row_size] = values[j]

#print(matrix_list)
process_per_core = math.ceil(matrix_size/cores)
idle_cores = process_per_core*cores - matrix_size
temp_matrix = []
out_matrix = []
steps = int(row_size*column_size/process_per_core)
#print(steps)

for i in range(0,process_per_core):
    temp_matrix.append(values[i*steps:(i+1)*steps])

for i in range (0, len(temp_matrix[0])):
    for j in range (0, len(temp_matrix)):
        out_matrix.append(temp_matrix[j][i])

#print(out_matrix)

for j in range(0,len(out_matrix)): 
    matrix_list[j%row_size, j//row_size] = out_matrix[j]

max_rows = math.ceil(matrix_size/cores)
min_rows = math.floor(matrix_size/cores)




final_matrix = np.zeros((matrix_size,column_size))
final_matrix[:max_rows,:] = matrix_list[:max_rows,:]
for i in range (0,cores-1-idle_cores):
    final_matrix[max_rows*(i+1):max_rows*(i+2),:] = matrix_list[max_rows*(i+1):max_rows*(i+2),:]
for i in range (0,idle_cores):
    final_matrix[(cores-idle_cores)*max_rows+(i*min_rows):(cores-idle_cores)*max_rows+((i+1)*min_rows),:] = matrix_list[(cores-idle_cores)*max_rows+(i*max_rows):(cores-idle_cores)*max_rows+(i*max_rows)+min_rows,:]


print ("Expected Matrix :")
f = open("C:/Users/Vinith Kugathasan/OneDrive/Desktop/out_matrix.txt", "r")
data = (f.readlines())

real_out = np.zeros((matrix_size,column_size))
for i in range (0, len(data)):
    data[i] = data[i].split(" ")
for i in range (0, len(data)):
    data[i] = data[i][0].split(":")[1]
    data[i] = data[i].split(";")[0]
    real_out[i%matrix_size, i//matrix_size] = int(data[i])
print(real_out)

print ("Calculated Matrix :")
print(final_matrix)

comparison_matrix = np.zeros((matrix_size,column_size))

print ("Comparison :")
for i in range(matrix_size):
    for j in range(column_size):
        if real_out[i][j]==final_matrix[i][j]:
            comparison_matrix[i][j] = 1
        else:
            comparison_matrix[i][j] = 0

print(comparison_matrix)
print("Matrix Dimension :", final_matrix.shape)
print("No. of Cores :", cores)