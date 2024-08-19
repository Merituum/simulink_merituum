function p = smldPe54(snr_in_db)
%this function calculates the probability of an error in respect to SNR in
%dB

%parameters of simulation, respectly: number of bits, energy of a signal,

N=1500;
E=1;
%conversion from dB scale to linear, compute of sigma
SNR=10.^(snr_in_db/10);
sigma_=E/sqrt(2*SNR);

data_source=randi([0,1],1,N);
noise_0=sigma_*randn(1,N); %addition noise to '0' signal
noise_1=sigma_*randn(1,N); %-.- '1'

%received signals
r0=E*(data_source==0)+noise_0; 
r1=E*(data_source==1)+noise_1;


%decision making; choosing of highier signal
decission=r0<r1;
%calculation of errors
numoreff=sum(decission ~=data_source);

p=numoreff/N;


end

