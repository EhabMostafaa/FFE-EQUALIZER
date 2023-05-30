close all;
clear all;
clc;

%% vectors
all_data=[];
data_valid=[];
data_valid_bin=[];

output_vector=[];
output_vector_fixed=[];
output_vector_bin=[];


%% generate 1000 random integers between -128 and 128
random_integers = randi([-64,64], 1, 1000); 

%% loop to store all input data
for i=1:length(random_integers)
     data=random_integers(i);
     all_data_bin=sfi(data,12,0).bin;
     all_data=[all_data ; all_data_bin ];
end

%% loop to store only valid data ( element every 4 elements)
for i=1:4:length(random_integers)
    data=random_integers(i);
    data_valid=[data_valid data];
    
    data_bin=sfi(data,12,0).bin;
    data_valid_bin=[data_valid_bin ; data_bin];
    
end    

%% generation of FFE Mutliplier
data1=data_valid(1)*.5;
data2=data_valid(1)*-.25+.5*data_valid(2);
data3=data_valid(1)*.15625-.25*data_valid(2)+data_valid(3)*.5;
output_vector=[data1 data2 data3];

for i=4:length(data_valid)
    calc_data=data_valid(i)*.5 -.25*data_valid(i-1) +.15625*data_valid(i-2) -.0625*data_valid(i-3);
    output_vector=[output_vector calc_data];
end 

%% loop to convert outputs to fixed point reperesentation (1 sign + 6 integers + 5 fractions )
for i=1:250
     data=output_vector(i);
     
     data_fixed=sfi(data,12,5);
     output_vector_fixed=[output_vector_fixed data_fixed];
   
     data_bin=sfi(data,12,5).bin;
     output_vector_bin=[output_vector_bin ; data_bin];
end     
