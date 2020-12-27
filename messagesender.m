message=input("Enter message to be sent\n",'s');
%user input message

bits=morse_encoder(message);
SNR=input("enter SNR\n");
distortedsig=bpsk_modulator(bits,SNR);%giving SNR as second input

bitdemod=bpsk_demodulator(distortedsig);

bitdemod=string(bitdemod);

bits=string(bits);
str="";

for k=1:length(bitdemod)
    str=str+bitdemod{k};
end
disp("recovered message is:")
disp(morse_decoder(str))
