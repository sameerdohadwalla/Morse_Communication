function [distortedsignal] = bpsk_modulator(bits,SNR)
bitsmod=-2*bits+1+0*1i;
%bpskModulator = comm.BPSKModulator;
%modData = bpskModulator(bits.');
distortedsig = awgn(bitsmod,SNR,'measured')%adding awgn in terms of Db
distortedsignal = distortedsig;
end

