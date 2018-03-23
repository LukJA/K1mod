set_global_assignment -entity "fivetoten" -library "lib_fivetoten" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "fivetoten" -library "lib_fivetoten" -name IP_TOOL_VERSION "17.0"
set_global_assignment -entity "fivetoten" -library "lib_fivetoten" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_fivetoten" -name SPD_FILE [file join $::quartus(sip_path) "fivetoten.spd"]

set_global_assignment -library "lib_fivetoten" -name MISC_FILE [file join $::quartus(sip_path) "fivetoten_sim/fivetoten.vho"]
