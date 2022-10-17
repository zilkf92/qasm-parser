# qasm-parser

The project includes a stand-alone parser for [*QASM*](https://arxiv.org/abs/1707.03429) files. The parser is a part of the compiler pipeline of the [PhotonQ compiler](https://github.com/CDL-Uni-Vienna/photonq-compiler) project.
<br>

## Overview

This repository contains the source files of a parser built with Flex and Bison that translates standard *QASM* 2.0 files consisting of $\{R_z(\theta), R_x(\theta), H, CNOT, CZ\}$ gates into *QASM* 2.0 files consisting of $\{HR_z(\theta), CZ\}$ gates using gate identities.

The first test versions of the parser were based on examples taken from [Levine's book](https://www.oreilly.com/library/view/flex-bison/9780596805418/) and then adapted accordingly for use in translating QASM files.

The lex file `parser.l` contains Flex code that defines the regular expressions and character tokens for which the input file is scanned.

The yacc file `parser.y` contains Bison code that defines the relationship between the input tokens as recursive grammar rules.

## Cloning the parser to your computer

To try the parser yourself you can clone the repo with

```
git clone https://github.com/zilkf92/qasm-parser.git
```

The repository contains 2 branches:

### **pi-constant** branch
Here, the string "pi" is interpreted as a mathematical constant from the `<math.h>` header and all other numbers are interpreted as integers or floats. E.g.:
```
rz(pi/4) q[8];
cx q[8],q[7];
rx(2*pi) q[7];
```
is converted to
```
rz(0.785398) q[8];
h q[8];
rz(0) q[8];
h q[8];
rz(0) q[7];
h q[7];
cz q[8], q[7];
rz(0) q[7];
h q[7];
rz(0) q[7];
h q[7];
rz(6.283185) q[7];
h q[7];
```

### **main** branch
Here, each argument of a *QASM* gate (parameter and qubit assignment) is interpreted and parsed as a string. E.g.:
```
rz(pi/4) q[8];
cx q[8],q[7];
```
is converted to
```
rz(pi/4) q[8];
h q[8];
rz(0) q[8];
h q[8];
rz(0) q[7];
h q[7];
cz q[8],q[7];
rz(0) q[7];
h q[7];
```

## Using the parser

After copying the repository, you can use, e.g., *Qiskit* to transpile an arbitrary quantum circuit into the gate set $\{R_z(\theta), R_x(\theta), H, CNOT, CZ\}$ and export the *QASM* file. You can use this *QASM* file as an input for the parser. Replace the `input.qasm` file with your generated *QASM* file and run the `./parser` file in the "parser" folder. This will create an `output.qasm` file according to the following translation rules:

$R_z(\theta) = [H R_z(0)][H R_z(\theta)]$

$R_x(\theta) = [H R_z(\theta)][H R_z(0)]$

$H = [H R_z(0)]$

$CNOT =[\mathbb{I}\otimes H] CZ [\mathbb{I}\otimes H]$

$CZ = CZ$