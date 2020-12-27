function [bitdemodulated] = bpsk_demodulator(distortedsig)
bitdemod=[]
for z=1:length(distortedsig)
    if(distortedsig(z)<-0.048)%demodulating signal using threshold derived from MAP rule
        bitdemod=[bitdemod 1];
    end
    if(distortedsig(z)>=0.048)
        bitdemod=[bitdemod 0];
    end
end
bitdemodulated = bitdemod;
end

