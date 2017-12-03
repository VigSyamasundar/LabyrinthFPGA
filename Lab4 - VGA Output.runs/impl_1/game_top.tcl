proc start_step { step } {
  set stopFile ".stop.rst"
  if {[file isfile .stop.rst]} {
    puts ""
    puts "*** Halting run - EA reset detected ***"
    puts ""
    puts ""
    return -code error
  }
  set beginFile ".$step.begin.rst"
  set platform "$::tcl_platform(platform)"
  set user "$::tcl_platform(user)"
  set pid [pid]
  set host ""
  if { [string equal $platform unix] } {
    if { [info exist ::env(HOSTNAME)] } {
      set host $::env(HOSTNAME)
    }
  } else {
    if { [info exist ::env(COMPUTERNAME)] } {
      set host $::env(COMPUTERNAME)
    }
  }
  set ch [open $beginFile w]
  puts $ch "<?xml version=\"1.0\"?>"
  puts $ch "<ProcessHandle Version=\"1\" Minor=\"0\">"
  puts $ch "    <Process Command=\".planAhead.\" Owner=\"$user\" Host=\"$host\" Pid=\"$pid\">"
  puts $ch "    </Process>"
  puts $ch "</ProcessHandle>"
  close $ch
}

proc end_step { step } {
  set endFile ".$step.end.rst"
  set ch [open $endFile w]
  close $ch
}

proc step_failed { step } {
  set endFile ".$step.error.rst"
  set ch [open $endFile w]
  close $ch
}

set_msg_config -id {Common 17-41} -limit 10000000

start_step init_design
set ACTIVE_STEP init_design
set rc [catch {
  create_msg_db init_design.pb
  set_param xicom.use_bs_reader 1
  create_project -in_memory -part xc7a100tcsg324-1
  set_property design_mode GateLvl [current_fileset]
  set_param project.singleFileAddWarning.threshold 0
  set_property webtalk.parent_dir {H:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.cache/wt} [current_project]
  set_property parent.project_path {H:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.xpr} [current_project]
  set_property ip_output_repo {{H:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.cache/ip}} [current_project]
  set_property ip_cache_permissions {read write} [current_project]
  set_property XPM_LIBRARIES XPM_CDC [current_project]
  add_files -quiet {{H:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.runs/synth_1/game_top.dcp}}
  read_ip -quiet {{H:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.srcs/sources_1/ip/clk_wiz_0_1/clk_wiz_0.xci}}
  set_property is_locked true [get_files {{H:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.srcs/sources_1/ip/clk_wiz_0_1/clk_wiz_0.xci}}]
  read_ip -quiet {{H:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.srcs/sources_1/ip/dist_mem_gen_0/dist_mem_gen_0.xci}}
  set_property is_locked true [get_files {{H:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.srcs/sources_1/ip/dist_mem_gen_0/dist_mem_gen_0.xci}}]
  read_ip -quiet {{H:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.srcs/sources_1/ip/dist_mem_gen_minecraftDirt/dist_mem_gen_minecraftDirt.xci}}
  set_property is_locked true [get_files {{H:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.srcs/sources_1/ip/dist_mem_gen_minecraftDirt/dist_mem_gen_minecraftDirt.xci}}]
  read_ip -quiet {{H:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.srcs/sources_1/ip/dis_mem_gen_ball2/dis_mem_gen_ball2.xci}}
  set_property is_locked true [get_files {{H:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.srcs/sources_1/ip/dis_mem_gen_ball2/dis_mem_gen_ball2.xci}}]
  read_ip -quiet {{h:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.srcs/sources_1/ip/dist_mem_gen_astro_1/dist_mem_gen_astro.xci}}
  set_property is_locked true [get_files {{h:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.srcs/sources_1/ip/dist_mem_gen_astro_1/dist_mem_gen_astro.xci}}]
  read_ip -quiet {{h:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.srcs/sources_1/ip/dist_mem_gen_xilinx/dist_mem_gen_xilinx.xci}}
  set_property is_locked true [get_files {{h:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.srcs/sources_1/ip/dist_mem_gen_xilinx/dist_mem_gen_xilinx.xci}}]
  read_ip -quiet {{h:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.srcs/sources_1/ip/dist_mem_gen_minecraftCobStone/dist_mem_gen_minecraftCobStone.xci}}
  set_property is_locked true [get_files {{h:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.srcs/sources_1/ip/dist_mem_gen_minecraftCobStone/dist_mem_gen_minecraftCobStone.xci}}]
  read_ip -quiet {{h:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.srcs/sources_1/ip/dist_mem_gen_earth/dist_mem_gen_earth.xci}}
  set_property is_locked true [get_files {{h:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.srcs/sources_1/ip/dist_mem_gen_earth/dist_mem_gen_earth.xci}}]
  read_ip -quiet {{h:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.srcs/sources_1/ip/dist_mem_gen_windows/dist_mem_gen_windows.xci}}
  set_property is_locked true [get_files {{h:/ES3B2/LabyrinthFPGA/Lab4 - VGA Output.srcs/sources_1/ip/dist_mem_gen_windows/dist_mem_gen_windows.xci}}]
  read_xdc {{H:/ES3B2/LabyrinthFPGA/Nexys4 _Master.xdc}}
  link_design -top game_top -part xc7a100tcsg324-1
  close_msg_db -file init_design.pb
} RESULT]
if {$rc} {
  step_failed init_design
  return -code error $RESULT
} else {
  end_step init_design
  unset ACTIVE_STEP 
}

start_step opt_design
set ACTIVE_STEP opt_design
set rc [catch {
  create_msg_db opt_design.pb
  opt_design 
  write_checkpoint -force game_top_opt.dcp
  catch { report_drc -file game_top_drc_opted.rpt }
  close_msg_db -file opt_design.pb
} RESULT]
if {$rc} {
  step_failed opt_design
  return -code error $RESULT
} else {
  end_step opt_design
  unset ACTIVE_STEP 
}

start_step place_design
set ACTIVE_STEP place_design
set rc [catch {
  create_msg_db place_design.pb
  implement_debug_core 
  place_design 
  write_checkpoint -force game_top_placed.dcp
  catch { report_io -file game_top_io_placed.rpt }
  catch { report_utilization -file game_top_utilization_placed.rpt -pb game_top_utilization_placed.pb }
  catch { report_control_sets -verbose -file game_top_control_sets_placed.rpt }
  close_msg_db -file place_design.pb
} RESULT]
if {$rc} {
  step_failed place_design
  return -code error $RESULT
} else {
  end_step place_design
  unset ACTIVE_STEP 
}

start_step route_design
set ACTIVE_STEP route_design
set rc [catch {
  create_msg_db route_design.pb
  route_design 
  write_checkpoint -force game_top_routed.dcp
  catch { report_drc -file game_top_drc_routed.rpt -pb game_top_drc_routed.pb -rpx game_top_drc_routed.rpx }
  catch { report_methodology -file game_top_methodology_drc_routed.rpt -rpx game_top_methodology_drc_routed.rpx }
  catch { report_power -file game_top_power_routed.rpt -pb game_top_power_summary_routed.pb -rpx game_top_power_routed.rpx }
  catch { report_route_status -file game_top_route_status.rpt -pb game_top_route_status.pb }
  catch { report_clock_utilization -file game_top_clock_utilization_routed.rpt }
  catch { report_timing_summary -warn_on_violation -max_paths 10 -file game_top_timing_summary_routed.rpt -rpx game_top_timing_summary_routed.rpx }
  close_msg_db -file route_design.pb
} RESULT]
if {$rc} {
  write_checkpoint -force game_top_routed_error.dcp
  step_failed route_design
  return -code error $RESULT
} else {
  end_step route_design
  unset ACTIVE_STEP 
}

start_step write_bitstream
set ACTIVE_STEP write_bitstream
set rc [catch {
  create_msg_db write_bitstream.pb
  set_property XPM_LIBRARIES XPM_CDC [current_project]
  catch { write_mem_info -force game_top.mmi }
  write_bitstream -force game_top.bit 
  catch {write_debug_probes -no_partial_ltxfile -quiet -force debug_nets}
  catch {file copy -force debug_nets.ltx game_top.ltx}
  close_msg_db -file write_bitstream.pb
} RESULT]
if {$rc} {
  step_failed write_bitstream
  return -code error $RESULT
} else {
  end_step write_bitstream
  unset ACTIVE_STEP 
}

