function dydt = HodgkinHuxleyEqs(t, y)
    % Constants
    Cm = 1;           % Membrane capacitance (uF/cm^2)
    gNa = 120;        % Maximal Na+ conductance (mS/cm^2)
    gK = 36;          % Maximal K+ conductance (mS/cm^2)
    gL = 0.3;         % Leakage conductance (mS/cm^2)
    ENa = 115;        % Na+ reversal potential (mV)
    EK = -12;         % K+ reversal potential (mV)
    EL = 10.6;        % Leakage reversal potential (mV)
    I_ext = 10;       % External current (uA/cm^2)

    % Variables
    V = y(1);  % Membrane voltage (mV)
    n = y(2);  % K+ activation gate
    m = y(3);  % Na+ activation gate
    h = y(4);  % Na+ inactivation gate

    % Ion currents
    INa = gNa * (m^3) * h * (V - ENa);  % Na+ current
    IK = gK * (n^4) * (V - EK);         % K+ current
    IL = gL * (V - EL);                 % Leakage current

    % Differential equations
    dVdt = (I_ext - (INa + IK + IL)) / Cm;

    % Gating variable dynamics
    dn_dt = alpha_n(V) * (1 - n) - beta_n(V) * n;
    dm_dt = alpha_m(V) * (1 - m) - beta_m(V) * m;
    dh_dt = alpha_h(V) * (1 - h) - beta_h(V) * h;

    % Return derivatives
    dydt = [dVdt; dn_dt; dm_dt; dh_dt];
end

% Helper functions for gating variables
function an = alpha_n(V)
    an = 0.01 * (10 - V) / (exp((10 - V) / 10) - 1);
end

function bn = beta_n(V)
    bn = 0.125 * exp(-V / 80);
end

function am = alpha_m(V)
    am = 0.1 * (25 - V) / (exp((25 - V) / 10) - 1);
end

function bm = beta_m(V)
    bm = 4 * exp(-V / 18);
end

function ah = alpha_h(V)
    ah = 0.07 * exp(-V / 20);
end

function bh = beta_h(V)
    bh = 1 / (exp((30 - V) / 10) + 1);
end
