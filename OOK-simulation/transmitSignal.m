function transmitSignal(file, file2, samp_rate, carrier_freq)
fs = samp_rate;    % sample rate; aliasing when fs/2 > freq 
fc = carrier_freq; % carrier frequency

data = real(abs(read_complex_binary(file))); % signal

ndata = NaN(1,length(data)); % cleaned signal
cutoff = max(data) * .5;     % used to determine which pulses 
                             % will be 0 and which will be 1
%cleans signal
for n = 1:length(data)    % this assigns the pulses to 1 or 0
    if (data(n) > cutoff) % depending if greater or less than cutoff
        ndata(n) = 1;
    else
        ndata(n) = 0;  
    end
end

N = 1:length(ndata);      % array of indices of data
t = N./fs;                % time at which pulse occurs
cwave = NaN(1,length(t)); % carrier wave

for n=1:length(t)
    cwave(n) = exp((1i)*2*pi*fc*t(n));
end

transmitW = cwave.*ndata;

figure(1)
plot(real(transmitW))

write_complex_binary(transmitW, file2);

end