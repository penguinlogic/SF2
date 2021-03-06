%layers = 5; k = 1; delta = 25;
%DWT_full(X,layers,DWT_steps(layers,k)*delta);

    scan = [];
    % scanning direction, (1 for up, 0 for down)
    dir = 0;
    for k = 2:2*N
        dir = 1-dir;
        
       
        
        if dir == 1
           for row = k:-1:1
               col = ((k+1)-row);
               if row <= N && col <= N,
                 scan = [scan ((row-1)*N+col)];  
               end
           end
        else
            for col = k:-1:1
               row = ((k+1)-col);
               if row <= N && col <= N,
                 scan = [scan ((row-1)*N+col)];
               end
            end
        end
        
    end