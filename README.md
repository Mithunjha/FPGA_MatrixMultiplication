# FPGA_MatrixMultiplication
This repository contains the details of the design and implementation of the custom processor designed to utilize multiple cores to do matrix multiplication using Field Programmable Gate Array. The processor was initially designed to do the multiplication of square matrices and then was enhanced to the multiplication of rectangular matrices. 

The design proposed in this report is capable of doing multiplication of the matrices with the number of rows or columns up to 16 and with values of the matrix elements in the range of 0 – 63. The number of cores in the design can be increased up to six, and this limitation is caused due to the decimal to binary limitation in MATLAB, which is an external factor. The ability to vary the number of cores in the multi-core processor is an additional advantage of our design. 

Verilog codes for single core processor, Multicore processor are available in the repository.Comparison between the time taken for matrix multiplication by different numbers of cores and MATLAB was conducted to validate the efficiency of the design. All the necessary details and documents to reproduce this design are attached to the report.