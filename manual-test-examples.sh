# Call stack to test:
#
# show_colors_fg_bg_rgb
#   cycle_216_8bit_colors_rgb
#     show_bg_color_for_each_fg_color
#       cycle_216_8bit_colors_rgb 
#         show_bg_color_with_fg_color
#           calculate_color_number 2x
# 
#

cycle_216_8bit_colors_rgb 'printf "x:%s y:%s z:%s"\\n'

show_bg_color_with_fg_color 1 2 3 4 5 0
show_bg_color_with_fg_color 0 1 2 3 4 5

show_bg_color_for_each_fg_color 1 2 3
show_bg_color_for_each_fg_color 2 3 4
show_bg_color_for_each_fg_color 1 3 5


# some functions to help isolate different calls to cycle_216_8bit_colors_rgb in the call stack
function test_cycle_1 () {
  x1=$1; y1=$2; z1=$3;
  printf "test_cycle_1 %s %s %s\\n" $x1 $y1 $z1
  cycle_216_8bit_colors_rgb "test_cycle_2 $x1 $y1 $z1"
}

function test_cycle_2 () {
  x1=$1; y1=$2; z1=$3;
  x2=$4; y2=$5; z2=$6;
  printf "    test_cycle_2 %s %s %s %s %s %s\\n" $x1 $y1 $z1 $x2 $y2 $z2
}

cycle_216_8bit_colors_rgb 'test_cycle_1'


function another_xyz_loop () {
  different_callback=$1

  for local xxx in {0..5} ; do # color cube x-coord color
    for yyy in {0..5} ; do # color cube y-coord color
      for zzz in {0..5} ; do # color cube z-coord color
        eval "$different_callback $xxx $yyy $zzz"
      done
    done
  done
}

# passes
another_xyz_loop 'test_cycle_1'

# a real test of cycle_216_8bit_colors_rgb
cycle_216_8bit_colors_rgb "show_bg_color_for_each_fg_color"


