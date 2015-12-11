function [] = send(l) %l is number of symbols
    fb = 2;     % symbols per second
    fc = 10;    % carrier frequency
    fs = 10*fc; % sampling frequency

    Tb = 1/fb;  % baud interval, seconds per symbol
    dt = 1/fs;  % delta t
    Nb = Tb/dt; % number of steps per baud period

    t = -l*Tb:dt:l*Tb;           % time interval array
    delta = zeros(1, length(t)); % delta function array
    sym = NaN(1,l);              % array of symbols

    for n = 1:l
        sym(n) = randi([0,3]);  
        delta(Nb*(n+2)) = exp(1i*(pi/2)*(sym(n)-(3/2))); %Z = e^(iphi)    
    end

    PTx = sinc((2*t)/Tb).*exp(1i*2*pi*fc*t); % transmit filter array

    msg = conv(PTx,delta,'same'); % convolution of the transmit
                                  % filter and complex symbols                              
    figure(1)
    plot3(t, real(PTx), imag(PTx))
    
    figure(2)
    plot3(t, real(msg), imag(msg))

    % disp(delta);
    disp(length(delta));
    display(length(PTx));

    save('sig', 'msg'); % msg is .mat file 
                        % sig is variable name

end

