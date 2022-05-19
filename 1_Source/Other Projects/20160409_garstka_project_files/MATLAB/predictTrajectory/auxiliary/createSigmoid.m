function [ sig ] = createSigmoid( t,tstart,tend,gain )
    
sig = gain/2 + gain/2 * tanh((t-(tstart+((tend-tstart)/2))) * (4/(tend-tstart)));

end

