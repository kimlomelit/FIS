%crear FIS
tipFIS=mamfis(...
    'name','fuzzy tipping',...
    'numinputs',2,'numinputMFs',3,...
    'numoutputs',1,'numoutputMFs',3,...
    'addrule','none'...
    );

%actualizar entrada 1
tipFIS.Inputs(1).name='servicio';
tipFIS.Inputs(1).Range=[0 10];
tipFIS.Inputs(1).MembershipFunctions(1).Name='pobre';
tipFIS.Inputs(1).MembershipFunctions(1).Type='gaussmf';
tipFIS.Inputs(1).MembershipFunctions(1).Parameters=[1.5 0];
tipFIS.Inputs(1).MembershipFunctions(2).Name='buena';
tipFIS.Inputs(1).MembershipFunctions(2).Type='gaussmf';
tipFIS.Inputs(1).MembershipFunctions(2).Parameters=[1.5 5];
tipFIS.Inputs(1).MembershipFunctions(3).Name='excelente';
tipFIS.Inputs(1).MembershipFunctions(3).Type='gaussmf';
tipFIS.Inputs(1).MembershipFunctions(3).Parameters=[1.5 10];

%actualizar entrada 2
tipFIS.Inputs(2).name='food';
tipFIS.Inputs(2).Range=[0 10];
tipFIS.Inputs(2).MembershipFunctions(1).Name='rancio';
tipFIS.Inputs(2).MembershipFunctions(1).Type='trapmf';
tipFIS.Inputs(2).MembershipFunctions(1).Parameters=[0 0 2 4];
tipFIS.Inputs(2).MembershipFunctions(2).Name='bien';
tipFIS.Inputs(2).MembershipFunctions(2).Type='trapmf';
tipFIS.Inputs(2).MembershipFunctions(2).Parameters=[2 4 6 8];
tipFIS.Inputs(2).MembershipFunctions(3).Name='delicioso';
tipFIS.Inputs(2).MembershipFunctions(3).Type='trapmf';
tipFIS.Inputs(2).MembershipFunctions(3).Parameters=[6 8 10 10];


%actualizar salida
tipFIS.Outputs(1).Name='propina';
tipFIS.Outputs(1).Range=[0 30];
tipFIS.Outputs(1).MembershipFunctions(1).Name='baja';
tipFIS.Outputs(1).MembershipFunctions(1).Type='trimf';
tipFIS.Outputs(1).MembershipFunctions(1).Parameters=[0 5 15];
tipFIS.Outputs(1).MembershipFunctions(2).Name='promedio';
tipFIS.Outputs(1).MembershipFunctions(2).Type='trimf';
tipFIS.Outputs(1).MembershipFunctions(2).Parameters=[5 15 25];
tipFIS.Outputs(1).MembershipFunctions(3).Name='alta';
tipFIS.Outputs(1).MembershipFunctions(3).Type='trimf';
tipFIS.Outputs(1).MembershipFunctions(3).Parameters=[15 25 30];

subplot(3,1,1)
plotmf(tipFIS,'input',1,1000);
subplot(3,1,2)
plotmf(tipFIS,'input',2,1000);
subplot(3,1,3)
plotmf(tipFIS,'output',1,1000);

%especificas reglas difusas
rules=[...
    "If servicio is pobre or food is rancio then propina is baja";...
    "If servicio is buena then propina is promedio";...
    "If servicio is excelente or food is delicioso then propina is alta"...
    ];
figure
tipFIS=addRule(tipFIS,rules);
gensurf(tipFIS)

%agregar nuevas reglas
new_rule="If food is bien then propina is alta";
tipFIS=addRule(tipFIS,new_rule);
gensurf(tipFIS);