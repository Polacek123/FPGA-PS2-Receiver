#############################################################
#
#        Expansion board @ RPI connector of AUP-ZU3
#        JS @ Pwr.Edu.pl
#
#############################################################

############# Rotary Encoder
set_property PACKAGE_PIN AA8  [get_ports {ROT_A}]
set_property PACKAGE_PIN Y9   [get_ports {ROT_B}]
set_property IOSTANDARD LVCMOS33 [get_ports ROT_*]

############# PS/2 A
set_property PACKAGE_PIN AB10 [get_ports {PS2A_Data}]
set_property PACKAGE_PIN AB9  [get_ports {PS2A_Clk}]
set_property IOSTANDARD LVCMOS33 [get_ports PS2A_*]

############# PS/2 B
#set_property PACKAGE_PIN AA10 [get_ports {PS2B_Data}]
#set_property PACKAGE_PIN AC11 [get_ports {PS2B_Clk}]
#set_property IOSTANDARD LVCMOS33 [get_ports PS2B_*]

############ HDMI
#set_property PACKAGE_PIN AF11 [get_ports {HDMI_D2_P}]
#set_property PACKAGE_PIN AG11 [get_ports {HDMI_D2_N}]
#set_property PACKAGE_PIN AH11 [get_ports {HDMI_D1_P}]
#set_property PACKAGE_PIN AH12 [get_ports {HDMI_D1_N}]
#set_property PACKAGE_PIN AF10 [get_ports {HDMI_D0_P}]
#set_property PACKAGE_PIN AE10 [get_ports {HDMI_D0_N}]
#set_property PACKAGE_PIN AD12 [get_ports {HDMI_CK_P}]
#set_property PACKAGE_PIN AC12 [get_ports {HDMI_CK_N}]
#set_property IOSTANDARD LVCMOS33 [get_ports HDMI_*]

############# VGA
#set_property PACKAGE_PIN AH14 [get_ports {VGA_RED[2]}]
#set_property PACKAGE_PIN AG13 [get_ports {VGA_RED[1]}]
#set_property PACKAGE_PIN AH13 [get_ports {VGA_RED[0]}]
#set_property PACKAGE_PIN AH10 [get_ports {VGA_GRN[2]}]
#set_property PACKAGE_PIN AD11 [get_ports {VGA_GRN[1]}]
#set_property PACKAGE_PIN AG10 [get_ports {VGA_GRN[0]}]
#set_property PACKAGE_PIN AB11 [get_ports {VGA_BLUE[2]}]
#set_property PACKAGE_PIN AD10 [get_ports {VGA_BLUE[1]}]
#set_property PACKAGE_PIN AA11 [get_ports {VGA_BLUE[0]}]
#set_property PACKAGE_PIN AG14 [get_ports {VGA_HS}]
#set_property PACKAGE_PIN AF13 [get_ports {VGA_VS}]
#set_property IOSTANDARD LVCMOS33 [get_ports VGA_*]

############# OLED IIC
set_property PACKAGE_PIN AE12 [get_ports {OLED_SCL}]
set_property PACKAGE_PIN AF12 [get_ports {OLED_SDA}]
set_property IOSTANDARD LVCMOS33 [get_ports OLED_*]
set_property SLEW FAST [get_ports OLED_*]

