function [symbols] = decodeSignal(file)
    data = real(abs(read_complex_binary(file)));
    % plot(data)
    norm = data(1.35e5:3.3e5); % look at plot to get
    N = length(norm);          % left and right limits
    ndata = NaN(1,N);
    cutoff = max(norm)/2;

    %clean signal
    for n = 1:N
        if norm(n) > cutoff
            ndata(n) = 1;
        else
            ndata(n) = 0;
        end
    end

    plot(ndata);
    up = NaN(1,66);
    down = NaN(1,66); 

    a = 1;
    b = 1;

    for n = 1:N-1
        if ndata(n) < ndata(n+1)
            up(a) = n;
            a = a+1;
        end
        if ndata(n) > ndata(n+1)
            down(b) = n;
            b = b+1;
        end 
    end

    % disp(up);
    % disp(length(up));

    width = NaN(1,66);

    for n = 1:66
        width(n) = down(n) - up(n);
    end

    cut = mean(width);
    symbols = NaN(1,66);

    for n = 1:66          
        if width(n) > cut
            symbols(n) = 0;
        else
            symbols(n) = 1;
        end
    end

end
