set_global_assignment -entity "main" -library "lib_main" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "main" -library "lib_main" -name IP_TOOL_VERSION "17.0"
set_global_assignment -entity "main" -library "lib_main" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_main" -name SPD_FILE [file join $::quartus(sip_path) "main.spd"]

set_global_assignment -library "lib_main" -name MISC_FILE [file join $::quartus(sip_path) "main_sim/main.vho"]
