vlib work
vmap work work

vcom -2008 4b_counter.vhd
vcom -2008 hex_to_7_seg.vhd
vcom -2008 contador.vhd
vcom -2008 crono.vhd
vcom -2008 crono_tb.vhd

vsim work.crono_tb

add wave -r /*  ;

radix -unsigned 

run 11000ns