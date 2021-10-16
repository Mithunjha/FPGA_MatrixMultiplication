clear; 
clc; 
close all; 

% fid=fopen('data_8bits.txt');% open the .txt file of the data to be converted 
% temp=fscanf(fid,'%x');%scan file 
cores = 4;
n = 10; % row of 1st matrix
a = 1; % column of first matrix
b = 1; % column of second matrix
maximum_value = 63; %maximum value (since data memory word size is 8bits)
maximum_mem_location = 256;
matrix_A = (randi(maximum_value,[n,a])); %generate matrix with random values
transposed_matrix_A = matrix_A.';  %transpose
flatten_A = transposed_matrix_A(:); %column vector

matrix_B = (randi(maximum_value,[a,b]));   
transposed_matrix_B = matrix_B.';
flatten_B = transposed_matrix_B(:);



fid=fopen('C:/Users/Vinith Kugathasan/OneDrive/Desktop/Rectangular Core/N Core/data.mif','w');% open the .mif file to be written 
%fid=fopen('C:/Users/Vinith Kugathasan/OneDrive/Desktop/one_core_complete/Single_Core/data.mif','w');% open the .mif file to be written 
fprintf(fid,'WIDTH='+string(8*cores)+';\n');% write storage bit width 8 bits;
fprintf(fid,'DEPTH=2048 ;\n');% write memory depth 2048 
fprintf(fid,'ADDRESS_RADIX=UNS;\n');% write address type is unsigned integer 
%fprintf(fid,'DATA_RADIX=HEX;');
fprintf(fid,'DATA_RADIX=UNS;\n');% write The input data type is hexadecimal 
fprintf(fid,'CONTENT BEGIN\n');% starting content


n_temp = [];
for i = 1:cores
    n_temp = [n_temp flip(de2bi(n,8),2)];   
end
n_out = bi2de(flip(n_temp,2));
fprintf(fid,'\t%d:%d;\n',0,n_out);

maxrow_temp = [];
maxrow = ceil(n/cores);
for i = 1:cores
    maxrow_temp = [maxrow_temp flip(de2bi(maxrow,8),2)];   
end
maxrow_out = bi2de(flip(maxrow_temp,2));
fprintf(fid,'\t%d:%d;\n',1,maxrow_out);

a_temp = [];
for i = 1:cores
    a_temp = [a_temp flip(de2bi(a,8),2)];   
end
a_out = bi2de(flip(a_temp,2));
fprintf(fid,'\t%d:%d;\n',2,a_out);

b_temp = [];
for i = 1:cores
    b_temp = [b_temp flip(de2bi(b,8),2)];   
end
b_out = bi2de(flip(b_temp,2));
fprintf(fid,'\t%d:%d;\n',3,b_out);

if mod(n,cores)==0
    I1 = reshape(flatten_A,n*a/cores,cores);
    for i=0:((n*a)/cores)-1 
        I2 = flip(de2bi(I1(i+1,:),8),2);
        O = bi2de(flip(reshape(I2',1,cores*8),2));
        fprintf(fid,'\t%d:%d;\n',i+4, O); %print matrix A
    end
else
    count = mod(n, cores);
    I1 = [];
    up_lim = ceil(n/cores);
    down_lim = floor(n/cores);
    index = 0;
    for i=1:cores
        if count ~= 0
            count = count - 1;
            I1 = [I1 flatten_A(index+1 : index+(a*up_lim))];
            index = index + a*up_lim;
        else
            t = [flatten_A(index+1 : index+(a*down_lim)) ; zeros(a,1)];
            I1 = [I1 t];
            index = index + a*down_lim;
        end
    end
    for i=0:(a*up_lim)-1 
        I2 = flip(de2bi(I1(i+1,:),8),2);
        O = bi2de(flip(reshape(I2',1,cores*8),2));
        fprintf(fid,'\t%d:%d;\n',i+4, O); %print matrix A
    end
end

B_pattern = de2bi(flatten_B,8);
temp = [];
for i = 1 : cores
    temp = [temp B_pattern];
end
out_B = bi2de(temp);

for i=0:(a*b)-1
    fprintf(fid,'\t%d:%d;\n',i+4+maximum_mem_location, out_B(i+1));
end

% for i=0:(n^2)-1
%     fprintf(fid,'\t%d:%d;\n',i+2*(n^2),0);
% end

fprintf(fid,'END;\n');
fclose(fid);%Close the file
tic
%matrix_O = matrix_A * matrix_B;
matrix_O = bitxor(matrix_A, matrix_B);
toc
matrix_O
transposed_matrix_O = matrix_O.';  %transpose
flatten_O = transposed_matrix_O(:);

fid=fopen( 'C:/Users/Vinith Kugathasan/OneDrive/Desktop/out_matrix.txt','w');
for i=0:(n*b)-1
    fprintf(fid,'\t%d:%d;\n',i, matrix_O(i+1));
end
fclose(fid);%Close the file

