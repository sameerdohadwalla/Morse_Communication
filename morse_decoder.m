function [recmessage] = morse_decoder(str)
code = {[1,0,1,1,1];[1,1,1,0,1,0,1,0,1];[1,1,1,0,1,0,1,1,1,0,1];[1,1,1,0,1,0,1];[1];[1,0,1,0,1,1,1,0,1];[1,1,1,0,1,1,1,0,1];[1,0,1,0,1,0,1];[1,0,1];[1,0,1,1,1,0,1,1,1,0,1,1,1];[1,1,1,0,1,0,1,1,1];[1,0,1,1,1,0,1,0,1];[1,1,1,0,1,1,1];[1,1,1,0,1];[1,1,1,0,1,1,1,0,1,1,1];[1,0,1,1,1,0,1,1,1,0,1];[1,1,1,0,1,1,1,0,1,0,1,1,1];[1,0,1,1,1,0,1];[1,0,1,0,1];[1,1,1];[1,0,1,0,1,1,1];[1,0,1,0,1,0,1,1,1];[1,0,1,1,1,0,1,1,1];[1,1,1,0,1,0,1,0,1,1,1];[1,1,1,0,1,0,1,1,1,0,1,1,1];[1,1,1,0,1,1,1,0,1,0,1];[1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1];[1,0,1,0,1,1,1,0,1,1,1];[1,0,1,0,1,0,1,0,1,1,1,0,1,1,1];[1,0,1,0,1,0,1,0,1,1,1];[1,0,1,0,1,0,1,0,1];[1,1,1,0,1,0,1,0,1,0,1];[1,1,1,0,1,1,1,0,1,0,1,0,1];[1,1,1,0,1,1,1,0,1,1,1,0,1,0,1];[1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1];[1,1,1,0,1,1,1,0,1,1,1,0,1,1,1,0,1,1,1];[1,1,1]};
characters = {'A';'B';'C';'D';'E';'F';'G';'H';'I';'J';'K';'L';'M';'N';'O';'P';'Q';'R';'S';'T';'U';'V';'W';'X';'Y';'Z';'1';'2';'3';'4';'5';'6';'7';'8';'9';'0';''};
words=split(str,"0000000");%getting words
mrec="";
for h=1:length(words)
    wor="";
    chars=split(words{h},"000");%getting characters
    for u=1:length(chars)
        arr=[];
        for f=1:length(chars{u})
            arr=[arr int32(str2num(chars{u}(f)))];
        end
        for d=1:length(code)
            if length(code{d})==length(arr)%mapping codes to characters
            if code{d}==arr
                wor=wor+characters{d};
                break;
            end
            end
                  end
        
    end
    mrec=mrec+wor+" ";
end
recmessage = mrec;
end

