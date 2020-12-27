%NOTE:Due to the large window size taken in the moving average filter,
%the entire graph is shifted to the right, so dont consider samples from -1
%to zero while evaluating the graph
message="qwertyuiopasdfghjklzxcvbnm0123456789qwertyuiopasdfghjklzxcvbnm0123456789qwertyuiopasdfghjklzxcvbnm0123456789"
%all morse characters are represented
message=upper(message);
text = upper(message);
text = strsplit(text);%spilt into words
code = {[1,0,1,1,1];[1,1,1,0,1,0,1,0,1];[1,1,1,0,1,0,1,1,1,0,1];[1,1,1,0,1,0,1];[1];[1,0,1,0,1,1,1,0,1];[1,1,1,0,1,1,1,0,1];[1,0,1,0,1,0,1];[1,0,1];[1,0,1,1,1,0,1,1,1,0,1,1,1];[1,1,1,0,1,0,1,1,1];[1,0,1,1,1,0,1,0,1];[1,1,1,0,1,1,1];[1,1,1,0,1];[1,1,1,0,1,1,1,0,1,1,1];[1,0,1,1,1,0,1,1,1,0,1];[1,1,1,0,1,1,1,0,1,0,1,1,1];[1,0,1,1,1,0,1];[1,0,1,0,1];[1,1,1];[1,0,1,0,1,1,1];[1,0,1,0,1,0,1,1,1];[1,0,1,1,1,0,1,1,1];[1,1,1,0,1,0,1,0,1,1,1];[1,1,1,0,1,0,1,1,1,0,1,1,1];[1,1,1,0,1,1,1,0,1,0,1];[1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1];[1,0,1,0,1,1,1,0,1,1,1];[1,0,1,0,1,0,1,0,1,1,1,0,1,1,1];[1,0,1,0,1,0,1,0,1,1,1];[1,0,1,0,1,0,1,0,1];[1,1,1,0,1,0,1,0,1,0,1];[1,1,1,0,1,1,1,0,1,0,1,0,1];[1,1,1,0,1,1,1,0,1,1,1,0,1,0,1];[1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1];[1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1];[1,1,1]};
characters = {'A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z';'1';'2';'3';'4';'5';'6';'7';'8';'9';'0';''};
bits=[];
%%encode into ones and zeros
for i=1:length(text)
    for j=1:length(text{i})
        word=text{i};
        char=word(j);
        [~, index] = ismember(char, characters);
        bits=[bits code{index} [0,0,0]];
        end
 bits=[bits [0,0,0,0]];
   
end
%modulate to bpsk
bpskModulator = comm.BPSKModulator;
modData = bpskModulator(bits.');
q=-1;
charerr=[]
for i=0:550%change SNR from 0 to 10 in steps of 0.02
 
distortedsig = awgn(modData,q,'measured');%adding awgn in terms of Db
bitdemod=[];
q=q+0.02;
for z=1:length(distortedsig)%demodulating signal using threshold derived from MAP rule
    if(distortedsig(z)<-0.048)
        bitdemod=[bitdemod 1];
    end
    if(distortedsig(z)>=-0.048)
        bitdemod=[bitdemod 0];
    end
end
bitdemod=string(bitdemod)
bits=string(bits);
str="";

for k=1:length(bitdemod)
    str=str+bitdemod{k};
end
words=split(str,"0000000")%getting words
mrec="";
for h=1:length(words)
    wor="";
    chars=split(words{h},"000")%getting characters
    for u=1:length(chars)
        arr=[];
        for f=1:length(chars{u})
            arr=[arr int32(str2num(chars{u}(f)))];
        end
        check=0;
        for d=1:length(code)
            if length(code{d})==length(arr)%mapping codes to characters
            if code{d}==arr
                wor=wor+characters{d};
                check=1;
                break;
            end
            end
        end
              if check==0
                  wor=wor+"#";%if no character matches put #
              end
        
    end
    mrec=mrec+wor+" ";
end
mrec;
mrec=strsplit(mrec);
er=0
for t=1:length(mrec{1})
    try
    if mrec{1}(t) == text{1}(t)%comparing message and recovered text characterwise
        er=er+1;
        
    end
    end

end

charerr=[charerr 108-er];
end
x=linspace(-1,10,length(charerr));
windowSize = 50; 
b = (1/windowSize)*ones(1,windowSize);%taking moving average to try and reduce noise
a = 1;
y = filter(b,a,charerr./108);
plot(x,y)
title("character error rate vs SNR")
xlabel("SNR")
ylabel("character error rate")