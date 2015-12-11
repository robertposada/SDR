function [bin] = receive(msg, n) 
    fb = 2; % baud frequency
    fc = 10; % carrier frequency
    Tb = 1/fb; % baud period
    fs = 10*fc; % sampling frequency
    dt = 1/fs; % delta t
    Nb = Tb/dt;
    l = length(msg);
    t = -l/(2*fs):dt:l/(2*fs)-dt;
    Prx = sinc((2*t)/Tb).*exp(1i*2*pi*fc*t);

    figure(1)
    plot3(t, real(Prx), imag(Prx));

    dec = conv(Prx, msg, 'same'); %decoded message

    figure(2)
    plot3(t, real(dec), imag(dec))

    maxi = NaN(1,n);
    received = NaN(1,n);
    bin = NaN(1,n);

    for i = 1:n
        maxi(i) = d(Nb*(i+2));  
        received(i) = round((2/pi)*imag(log(maxi(i)))+(3/2));
    end

    for i = 1:n
         if received(i) == 3
             bin(i) = 1;
         elseif received(i) == 2
            bin(i) = 3;
        elseif received(i) == 1
            bin(i) = 2;
        else 
            bin(i) = 0;
        end
    end

    figure(3)
    plot(maxi, 'o')

    disp(received);

end