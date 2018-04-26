@echo off
set xv_path=D:\\Vivado\\Vivado\\2017.2\\bin
call %xv_path%/xsim CPU_top_sim_time_impl -key {Post-Implementation:sim_1:Timing:CPU_top_sim} -tclbatch CPU_top_sim.tcl -log simulate.log
if "%errorlevel%"=="0" goto SUCCESS
if "%errorlevel%"=="1" goto END
:END
exit 1
:SUCCESS
exit 0
