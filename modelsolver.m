tspan = [0 20]; % Sets the time span from 0 to 20 ms.
v_0=[-58 .05 .33 .6]; % These are the initial conditions at t=0 for the membrane voltage, m, n, and h before current is injected.
[t1,y1] = ode15s('HodgkinHuxleyEqs',tspan,v_0);

hold on;
plot(t1,y1(:,1));
title('Model of Action Potential Voltage')
xlabel('Time (ms)'),ylabel('Membrane Voltage (mV)')
figure(2)
hold off;

hold on;
plot(t1,y1(:,2),'r');
plot(t1,y1(:,3),'k');
plot(t1,y1(:,4),'g');
title('Model of Gates in Action Potential')
xlabel('Time (ms)'),ylabel('Gate Open Probability')
legend('m-gate','n-gate','h-gate')
figure(1)
hold off;
