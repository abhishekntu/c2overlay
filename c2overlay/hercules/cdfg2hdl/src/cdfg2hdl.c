/*
 * Filename: cdfg2hdl.c
 * Purpose : Top-level (driver) file of the "cdfg2hdl" program source code.
 * Author  : Nikolaos Kavvadias (C) 2009, 2010, 2011, 2012, 2013
 * Date    : 18-May-2013
 * Revision: x.y.z (18/05/13)
 *           Dummy version.
 */    

#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <math.h>


/* Definitions for VHDL compiler engines */
typedef enum {
  UNKNOWN_VHDL_COMPILER = -1,
  GHDL,      /* GHDL: http://ghdl.free.fr                        */
  MODELSIM,  /* Mentor Modelsim: http://www.mentor.com/modelsim/ */
  ISIM,      /* Xilinx ISE Simulator: http://www.xilinx.com      */
  FREEHDL    /* Edwin Naroska's FreeHDL (currently at 0.0.8)     */
} VHDLCompilerType;

/* Definitions for the possible quantization (truncation or rounding) modes 
 * in fixed-point arithmetic.
 */
typedef enum {
  UNKNOWN_QUANT_TYPE = -1,
  AC_TRN,         /* Default in ACDT (Algorithmic C Datatypes). */      
  AC_TRN_ZERO,         
  AC_RND,         /* Default in VHDL fixed-point package (D. Bishop). */      
  AC_RND_ZERO,      
  AC_RND_INF,      
  AC_RND_MIN_INF,      
  AC_RND_CONV        
} QuantizationType;

/* Definitions for the possible overflow-handling (wrapping or saturation) 
 * modes in fixed-point arithmetic.
 */
typedef enum {
  UNKNOWN_OVERFLOW_TYPE = -1,
  AC_WRAP,        /* Default in ACDT (Algorithmic C Datatypes). */      
  AC_SAT,         /* Default in VHDL fixed-point package (D. Bishop). */      
  AC_SAT_ZERO,
  AC_SAT_SYM
} OverflowType;


int enable_debug=0;
int enable_sched_sequential=0, enable_sched_asap=0, enable_sched_naive=0;
int enable_mpint=0, enable_streaming=0,enable_vhd2vl=0, use_rising_edge=0;
int use_component_pkg=0, enable_ghw=0, enable_vcd=0;
int enable_blockmem=0;
int enable_synopsys=1, enable_ieee=0;
int enable_hw_phis=0, enable_quick_abort=0;
/*int enable_fxp=0, set_quantization_mode=AC_TRN, set_overflow_mode=AC_WRAP;*/
int enable_flp=0, enable_flp_builtins=0;
int enable_force_ssa=0;
int set_simengine=GHDL;
int gen_compound_type_pkg=0;
int enable_read_through=0, enable_read_first=1;
/* Current procedure name (updated in "nac.y"). */
char gvizcdfg_file_name[48];
FILE *gvizcdfgin;


/* print_usage:
 * Print online help for "cdfg2hdl".
 */
static void print_usage()
{
  printf("\n");
  printf("* Usage:\n");
  printf("* cdfg2hdl [options] input.dot\n");
  printf("* \n");
  printf("* Options:\n");
  printf("* \n");
  printf("*   -d:\n");
  printf("*         Enable debug output (nothing yet).\n");
  printf("*   -sched-<mode>:\n");
  printf("*         Perform scheduling on predefined acyclic regions.\n");
  printf("*         Valid options for <mode>: {sequential, asap, naive}.\n");
  printf("*   -mpint:\n");
  printf("*         Use multiple-precision arithmetic as implemented\n");
  printf("*         by the public domain fgmp library.\n");
  printf("*   -streaming:\n");
  printf("*         Generate code for hardware units with streaming\n");
  printf("*         output(s), generating a sequence of values.\n");
  printf("*   -vhd2vl:\n");
  printf("*         Generate code more friendly to the \"vhd2vl\" tool.\n");
  printf("*   -use-rising-edge:\n");
  printf("*         Use calls to rising_edge for clock event detection.\n");
  printf("*   -use-component-pkg:\n");
  printf("*         Generate a package \"use\" for system-wide components.\n");
  printf("*   -ghw:\n");
  printf("*         Generate a GHDL Waveform file (.ghw) after simulation.\n");
  printf("*   -vcd:\n");
  printf("*         Generate a VCD waveform file (.vcd) after simulation.\n");
  printf("*   -read-through:\n");
  printf("*   -read-first:\n");
  printf("*         Specify the mode for block RAM synchronous reads\n");
  printf("*         (default: read-first).\n");
  printf("*   -blockmem:\n");
  printf("*         Generate embedded block memories via inference.\n");
  printf("*   -synopsys:\n");
  printf("*         Use the \"de-facto\" Synopsys \"IEEE\" library in the\n");
  printf("*         generated design code (default).\n");
  printf("*   -ieee:\n");
  printf("*         Use the normative IEEE library in the generated design\n");
  printf("*         code.\n");
  printf("*   -hw-phis:\n");
  printf("*         Generate hardware for direct support of phi statements.\n");
/*  
  printf("*   -fxp-trn-wrap:\n");
  printf("*         Support for fixed-point arithmetic with truncation\n");
  printf("          (quantization mode) and wrapping (overflow mode). This is");
  printf("          the default option.\n");
  printf("*   -fxp-trn-sat:\n");
  printf("*         Support for fixed-point arithmetic with truncation\n");
  printf("          (quantization mode) and saturation (overflow mode).\n");
  printf("*   -fxp-rnd-wrap:\n");
  printf("*         Support for fixed-point arithmetic with rounding\n");
  printf("          (quantization mode) and wrapping (overflow mode).\n");
  printf("*   -fxp-rnd-sat:\n");
  printf("*         Support for fixed-point arithmetic with rounding\n");
  printf("          (quantization mode) and saturation (overflow mode).\n");
*/  
  printf("*   -flp-arith:\n");
  printf("*         Support for floating-point arithmetic.\n");
  printf("*   -flp-builtins:\n");
  printf("*         Assume floating-point transcendental functions as primitives.\n");
  printf("*   -ghdl:\n");
  printf("*         Generate support files for GHDL simulation (default).\n");
  printf("*   -mti:\n");
  printf("*         Generate support files for Modelsim simulation.\n");
  printf("*   -quick-abort:\n");
  printf("*         Abort simulation immediately following the first error.\n");
  printf("* \n");
  printf("* For further information, please refer to the website:\n");
  printf("* http://www.nkavvadias.com\n");
}

/* main:
 * Entry point for the "cdfg2hdl" program.
 */
int main(int argc, char **argv)
{
  int i;
  int copied_gvizcdfg_file_name=0;
  
  /* Read input arguments. */
  if (argc < 2) {
    print_usage();
    exit(1);
  }

  for (i = 1; i < argc; i++) {
    if (strcmp("-d", argv[i]) == 0) {
      enable_debug = 1;
    } else if (strcmp("-sched-sequential", argv[i]) == 0) {
      enable_sched_sequential = 1;
      enable_sched_asap       = 0;
      enable_sched_naive      = 0;
    } else if (strcmp("-sched-asap", argv[i]) == 0) {
      enable_sched_sequential = 0;
      enable_sched_asap       = 1;
      enable_sched_naive      = 0;
    } else if (strcmp("-sched-naive", argv[i]) == 0) {
      enable_sched_sequential = 0;
      enable_sched_asap       = 0;
      enable_sched_naive      = 1;
    } else if (strcmp("-mpint", argv[i]) == 0) {
      enable_mpint = 1;
    } else if (strcmp("-streaming", argv[i]) == 0) {
      enable_streaming = 1;
    } else if (strcmp("-vhd2vl", argv[i]) == 0) {
      enable_vhd2vl = 1;
    } else if (strcmp("-use-rising-edge", argv[i]) == 0) {
      use_rising_edge = 1;
    } else if (strcmp("-use-component-pkg", argv[i]) == 0) {
      use_component_pkg = 1;
    } else if (strcmp("-ghw", argv[i]) == 0) {
      enable_ghw = 1;
      enable_vcd = 0;
    } else if (strcmp("-vcd", argv[i]) == 0) {
      enable_ghw = 0;
      enable_vcd = 1;
    } else if (strcmp("-read-first", argv[i]) == 0) {
      enable_read_first = 1;
      enable_read_through = 0;
    } else if (strcmp("-read-through", argv[i]) == 0) {
      enable_read_first = 0;
      enable_read_through = 1;
    } else if (strcmp("-blockmem", argv[i]) == 0) {
      enable_blockmem = 1;
    } else if (strcmp("-ieee", argv[i]) == 0) {
      enable_ieee = 1;
      enable_synopsys = 0;
    } else if (strcmp("-hw-phis", argv[i]) == 0) {
      enable_hw_phis = 1;
    } else if (strcmp("-synopsys", argv[i]) == 0) {
      enable_ieee = 0;
      enable_synopsys = 1;
/*      
    } else if (strcmp("-fxp-trn-wrap", argv[i]) == 0) {
      enable_fxp = 1;
      set_quantization_mode = AC_TRN;
      set_overflow_mode = AC_WRAP;
    } else if (strcmp("-fxp-trn-sat", argv[i]) == 0) {
      enable_fxp = 1;
      set_quantization_mode = AC_TRN;
      set_overflow_mode = AC_SAT;
    } else if (strcmp("-fxp-rnd-wrap", argv[i]) == 0) {
      enable_fxp = 1;
      set_quantization_mode = AC_RND;
      set_overflow_mode = AC_WRAP;
    } else if (strcmp("-fxp-rnd-sat", argv[i]) == 0) {
      enable_fxp = 1;
      set_quantization_mode = AC_RND;
      set_overflow_mode = AC_SAT;
*/      
    } else if (strcmp("-flp-arith", argv[i]) == 0) {
      enable_flp = 1;
    } else if (strcmp("-flp-builtins", argv[i]) == 0) {
      enable_flp_builtins = 1;
    } else if (strcmp("-no-force-ssa", argv[i]) == 0) {
      enable_force_ssa = 0;    
    } else if (strcmp("-ghdl", argv[i]) == 0) {
      set_simengine = GHDL;
    } else if (strcmp("-mti", argv[i]) == 0) {
      set_simengine = MODELSIM;
    } else if (strcmp("-quick-abort", argv[i]) == 0) {
      enable_quick_abort = 1;
    } else {
      if (argv[i][0] != '-') {
        if (copied_gvizcdfg_file_name==0) {
          strcpy(gvizcdfg_file_name,argv[i]);
          copied_gvizcdfg_file_name = 1;
        } else {
          print_usage();
          exit(1);
        }
      }
    }
  }

  /* infile (argv[1]) is passed as input to the gvizcdfg parser. */
  if (copied_gvizcdfg_file_name==0) {
    print_usage();
    exit(1);
  } else {
    gvizcdfgin = fopen(gvizcdfg_file_name, "r");
  }

  /* Reporting the invocation options for the current run of "cdfg2hdl". */
  fprintf(stdout, "### cdfg2hdl started operation. ###\n");  
  fprintf(stdout, "Info: Options used in the current run of \"cdfg2hdl\":\n");
  fprintf(stdout, "Info: gvizcdfg_file_name=%s\n", gvizcdfg_file_name);  
  fprintf(stdout, "Info: enable_debug=%d\n", enable_debug);
  fprintf(stdout, "Info: enable_sched_sequential=%d\n", enable_sched_sequential);
  fprintf(stdout, "Info: enable_sched_asap=%d\n", enable_sched_asap);
  fprintf(stdout, "Info: enable_sched_naive=%d\n", enable_sched_naive);
  fprintf(stdout, "Info: enable_ieee=%d\n", enable_ieee);
  fprintf(stdout, "Info: enable_synopsys=%d\n", enable_synopsys);
  fprintf(stdout, "Info: enable_mpint=%d\n", enable_mpint);
  fprintf(stdout, "Info: enable_streaming=%d\n", enable_streaming);
  fprintf(stdout, "Info: enable_vhd2vl=%d\n", enable_vhd2vl);
  fprintf(stdout, "Info: use_rising_edge=%d\n", use_rising_edge);
  fprintf(stdout, "Info: use_component_pkg=%d\n", use_component_pkg);
  fprintf(stdout, "Info: enable_ghw=%d\n", enable_ghw);
  fprintf(stdout, "Info: enable_vcd=%d\n", enable_vcd);
  fprintf(stdout, "Info: enable_blockmem=%d\n", enable_blockmem);
  fprintf(stdout, "Info: enable_read_through=%d\n", enable_read_through);
  fprintf(stdout, "Info: enable_read_first=%d\n", enable_read_first);
  fprintf(stdout, "Info: enable_force_ssa=%d\n", enable_force_ssa);
  fprintf(stdout, "Info: enable_hw_phis=%d\n", enable_hw_phis);
  fprintf(stdout, "Info: enable_quick_abort=%d\n", enable_quick_abort);
  fprintf(stdout, "Info: set_simengine=%d\n", set_simengine);
  fprintf(stdout, "Info: gen_compound_type_pkg=%d\n", gen_compound_type_pkg);
/*  
  fprintf(stdout, "Info: enable_fxp=%d\n", enable_fxp);
  fprintf(stdout, "Info: set_quantization_mode=%d\n", set_quantization_mode);
  fprintf(stdout, "Info: set_overflow_mode=%d\n", set_overflow_mode);
*/  
  fprintf(stdout, "Info: enable_flp=%d\n", enable_flp);
  fprintf(stdout, "Info: enable_flp_builtins=%d\n", enable_flp_builtins);
  fprintf(stdout, "### cdfg2hld completed operation. ###\n");  
  
  return 0;
}
