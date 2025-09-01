# MicroPhase Z7 Lite (XC7Z010)
#### Here, you will find the Vivado project setting for this Board (TCL Code) :

Create a Vivado project simply : 
```tcl
create_project <Name> C:/Users/XX/Documents/PROJETS/FPGA/MicroPhase/FPGA/<Name> -part xc7z010clg400-1
```
Example : 
```tcl
create_project Template C:/Users/shawn/Documents/PROJETS/FPGA/MicroPhase/FPGA/Template -part xc7z010clg400-1
```

Change VHDL as project Language : 
```tcl
set_property target_language VHDL [current_project]
```
