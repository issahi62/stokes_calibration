function sse = sseval(x,xdata,ydata)
A = x(1);
sse = sum((ydata - A*cos(xdata).^2).^2);