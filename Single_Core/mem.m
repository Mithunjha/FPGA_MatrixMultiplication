clear; 
clc; 
close all; 
% fid=fopen('data_8bits.txt');% open the .txt file of the data to be converted 
% temp=fscanf(fid,'%x');%scan file 
n=4; % matrix size (maximum is 16)
maximum_value = 63; %maximum value (since data memory word size is 8bits)
maximum_mem_location = 256;
matrix_A = (randi(maximum_value,[n,n])); %generate matrix with random values
transposed_matrix_A = matrix_A.';  %transpose
flatten_A = transposed_matrix_A(:); %column vector

matrix_B = (randi(maximum_value,[n,n]));   
transposed_matrix_B = matrix_B.';
flatten_B = transposed_matrix_B(:);

fid=fopen( 'F:/Single_Core/Single_Core/data.mif','w');% open the .mif file to be written 
fprintf(fid,'WIDTH=8;\n');% write storage bit width 8 bits 
fprintf(fid,'DEPTH=2048 ;\n');% write memory depth 2048 
fprintf(fid,'ADDRESS_RADIX=UNS;\n');% write address type is unsigned integer 
%fprintf(fid,'DATA_RADIX=HEX;');
fprintf(fid,'DATA_RADIX=UNS;\n');% write The input data type is hexadecimal 
fprintf(fid,'CONTENT BEGIN\n');% starting content

fprintf(fid,'\t%d:%d;\n',0,n);
for i=0:(n^2)-1 
    fprintf(fid,'\t%d:%d;\n',i+2, flatten_A(i+1)); %print matrix A
end
for i=0:(n^2)-1
    fprintf(fid,'\t%d:%d;\n',i+2+maximum_mem_location, flatten_B(i+1));
end

% for i=0:(n^2)-1
%     fprintf(fid,'\t%d:%d;\n',i+2*(n^2),0);
% end

fprintf(fid,'END;\n');
fclose(fid);%Close the file

matrix_O = matrix_A*matrix_B;
matrix_O
transposed_matrix_O = matrix_O.';  %transpose
flatten_O = transposed_matrix_O(:);
flatten_O;