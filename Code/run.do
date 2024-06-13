setup_design -manufacturer Xilinx -family Artix-7 -part 7A100TCSG324
foreach arg $::argv {
  add_input_file $arg
}
compile
create_clock -period 10 -waveform { 0 5 } -name CLK CLK
synthesize
auto_write precision.v
report_output_file_list
report_area

# single worst path
report_timing

# report 3 worst paths
report_timing -num_paths 3

# but no more than 1 path per group (so you can see input -> ff, ff -> ff, 
#                                    and ff -> output delays)
report_timing -num_paths 3 -nworst 1
