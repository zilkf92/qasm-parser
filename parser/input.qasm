h q[0];
rz(pi/2+3) q[0];
cz q[0], q[1];
rx(55/2) q[1];
cx q[1], q[2];
h q[3];
rz(2*pi) q[0];
cz q[0], q[1];
rx(pi) q[1];
cx q[2], q[3];
rx(pi/8) q[3];