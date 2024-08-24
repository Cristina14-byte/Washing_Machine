# Washing_Machine
1st year-Digital System Design- VHDL Project




Design a simple washing machine control machine with one mode and several automatic modes. 

The machine is initially in idle, with the washing machine door open. The user can set the operating parameters manually (manual mode) or select one of the pre-programmed modes. 
In manual mode, you can set: temperature (30°C, 40°C, 60°C or 90°C); speed (800, 1000, 1200 rpm); pre-wash selection / cancellation, additional rinsing. The running time of the program depends on the selected temperature (water comes with a temperature of 15°C and heats up 1°C in 2 seconds) and the selected function (prewash - the same method as the main wash, additional rinsing - rinsing twice; functions are described in detail below). 

The selectable automatic modes are as follows: 
• Quick wash - 30°C, 1200 speed, no prewash, no extra rinsing 
• Shirts - 60°C, speed 800, no prewash, no extra rinsing 
• Dark colors - 40°C, speed 1000, no prewash, extra rinsing 
• Dirty laundry - 40°C, 1000 speed, with prewash, no extra rinsing 
• Antiallergic - 90°C, speed 1200, without prewash, extra rinsing 

Each program contains the following steps: main wash (feed the machine with water, heat the water, rotate at a speed of 60 rpm for 20 minutes, drain the water), rinse (feed with water, rotate with a speed of 120 rpm for 10 minutes, drain water) and spin (rotate at the selected speed for 10 minutes). If pre-wash is selected, it has the same method as the main wash, except that it rotates for 10 minutes. 

The door locks after the program starts and opens one minute after the program ends. The car does not start with the door open. 
While the desired mode is selected (manual or one of the automatic modes), the program duration is displayed and the remaining time is displayed after starting (the time is displayed on 7-segment displays). 
