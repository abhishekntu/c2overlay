/*
 * Filename: nac2cdfg.c
 * Purpose : Top-level (driver) file of the "nac2cdfg" program source code.
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

/* Upper limit for NAC operations in a translation unit. 
 * Meaningful only with "-limit-nacs".
 */
#define NAC_LIMIT       25

int enable_debug=0, enable_force_data_types=0, enable_permissive=0;
int enable_flp=0;
int enable_ssa=0, enable_emit_cfg=0, enable_emit_nac=0, enable_emit_ansic=0; 
int enable_dce=1, enable_keep_ssa=0, enable_limit_nacs=0, nac_count;
int use_pseudo_ssa=0, enable_phi_bbs=0, enable_unique_ssavars=0;
int dump_varnum_nac=0, dump_phiins_nac=0, dump_phimin_nac=0;
int dump_phielm_nac=0, dump_simdce_nac=0;
int dump_tgf=0, dump_arg=0, dump_grh=0, dump_poset=0;
int use_appel=0, use_aycockhorspool=1, enable_opt_spbb=0;
int enable_ra=0, use_lsra=0, dump_ra_nac=0;
int enable_gcc=1, enable_llvm=0;
char nac_file_name[48];
/**/
FILE *nacin;


/* print_usage:
 * Print online help for "nac2cdfg".
 */
static void print_usage()
{
  printf("\n");
  printf("* Usage:\n");
  printf("* nac2cdfg [options] input.nac\n");
  printf("* \n");
  printf("* Options:\n");
  printf("* \n");
  printf("*   -d:\n");
  printf("*         Enable debug output (nothing yet).\n");
  printf("*   -force-data-types:\n");
  printf("*         Force predefined data types as given in NAC code. Essentially\n");
  printf("*         disables the effect both interval analysis and the alternative\n");
  printf("*         of using the unknown data type \"na\".\n"); 
  printf("*   -permissive:\n");
  printf("*         Allows non-strict forms and macrostatements of the NAC programming\n");
  printf("*         language.\n"); 
  printf("*   -ssa:\n");
  printf("*         Internal construction of SSA (Static Single Assignment) form.\n");
  printf("*   -pseudo-ssa:\n");
  printf("*         Internal construction of local SSA-like form.\n");
  printf("*   -use-appel:\n");
  printf("*         Enables SSA construction using Appel's algorithm.\n");
  printf("*   -use-aycockhorspool:\n");
  printf("*         Enables SSA construction using the Aycock-Horspool algorithm\n");
  printf("*         (default).\n");
  printf("*   -opt-spbb:\n");
  printf("*         Enables optimization 3 as discussed in the Aycock-Horspool paper,\n");
  printf("*         which omits generating phi statements for single-predecessor BBs.\n");  
  printf("*         Supported only with -use-appel and -keep-ssa.\n");  
  printf("*   -keep-ssa:\n");
  printf("*         Does not perform out-of-SSA conversion and thus keeps PHI statements\n");
  printf("*         in the generated CDFGs.\n");
  printf("*   -phi-bbs:\n");
  printf("*         Enable the generation of BB arguments in \"phi\" statements.\n");
  printf("*   -no-phi-bbs:\n");
  printf("*         Disable the generation of BB arguments in \"phi\" statements (default).\n");
  printf("*   -unique-ssavars:\n");
  printf("*         Enable the generation of unique pseudo-SSA variable numbers.\n");
  printf("*   -ra:\n");
  printf("*         Enable register allocation.\n");
  printf("*   -linear-scan:\n");
  printf("*         Use the linear-scan algorithm for register allocation.\n");
  printf("*   -limit-nacs:\n");
  printf("*         Limits the number of NACs in a translation unit to NAC_LIMIT\n");
  printf("*         (about 25).\n");
  printf("*   -emit-nac:\n");
  printf("*         Emit the equivalent NAC program after processing (including SSA\n");
  printf("*         conversion, if enabled).\n");
  printf("*   -emit-ansic:\n");
  printf("*         Emit the equivalent ANSI C program after processing (including SSA\n");
  printf("*         conversion, if enabled).\n");
  printf("*   -emit-cfg:\n");
  printf("*         Generate the Graphviz representations for all procedure CFGs.\n");
  printf("*   -dump-varnum-nac:\n");
  printf("*         Dump the equivalent NAC program after SSA variable numbering.\n");
  printf("*   -dump-phiins-nac:\n");
  printf("*         Dump the equivalent NAC program after SSA PHI insertion.\n");
  printf("*   -dump-phimin-nac:\n");
  printf("*         Dump the equivalent NAC program after SSA PHI minimization.\n");
  printf("*   -dump-phielm-nac:\n");
  printf("*         Dump the equivalent NAC program after SSA PHI elimination.\n");
  printf("*   -dump-simdce-nac:\n");
  printf("*         Dump the equivalent NAC program after post-SSA dead code elimination.\n");
  printf("*   -dump-ra-nac:\n");
  printf("*         Dump the equivalent NAC program after register allocation.\n");
  printf("*   -dump-tgf:\n");
  printf("*         Dump TGF (Trivial Graph Format) representations of program\n");
  printf("*         information.\n");
  printf("*   -dump-arg:\n");
  printf("*         Dump ARG (attributed relational graph) representations of program\n");
  printf("*         information.\n");
  printf("*   -dump-grh:\n");
  printf("*         Dump simple edge-list representations of program information.\n");
  printf("*   -dump-poset:\n");
  printf("*         Dump poset (.p) file representations of program information.\n");
  printf("*   -gcc:\n");
  printf("*         Generate Makefile for GCC compilation (default).\n");
  printf("*   -llvm:\n");
  printf("*         Generate Makefile for LLVM compilation and/or interpretation.\n");
  printf("*   -flp:\n");
  printf("*         Enable the inclusion of floating-point VHDL libraries.\n");
  printf("* \n");
  printf("* For further information, please refer to the website:\n");
  printf("* http://www.nkavvadias.com\n\n");
}

/* main:
 * Entry point for "nac2cdfg".
 */
int main(int argc, char **argv)
{
  int i;
  int copied_nac_file_name=0;
  
  /* Read input arguments. */
  if (argc < 2) {
    print_usage();
    exit(1);
  }

  for (i=1; i < argc; i++) {
    if (strcmp("-d", argv[i]) == 0) {
      enable_debug = 1;
    } else if (strcmp("-force-data-types", argv[i]) == 0) {
      enable_force_data_types = 1;
    } else if (strcmp("-permissive", argv[i]) == 0) {
      enable_permissive = 1;
    } else if (strcmp("-ssa", argv[i]) == 0) {
      enable_ssa = 1;
    } else if (strcmp("-pseudo-ssa", argv[i]) == 0) {
      enable_ssa = 1;
      use_pseudo_ssa = 1;
      use_appel = 0;
      use_aycockhorspool = 0;
    } else if (strcmp("-no-phi-bbs", argv[i]) == 0) {
      enable_phi_bbs = 0;
    } else if (strcmp("-phi-bbs", argv[i]) == 0) {
      enable_phi_bbs = 1;
    } else if (strcmp("-use-appel", argv[i]) == 0) {
      use_appel = 1;
      use_aycockhorspool = 0;
    } else if (strcmp("-use-aycockhorspool", argv[i]) == 0) {
      use_appel = 0;
      use_aycockhorspool = 1;
    } else if (strcmp("-opt-spbb", argv[i]) == 0) {
      enable_opt_spbb = 1;
    } else if (strcmp("-keep-ssa", argv[i]) == 0) {
      enable_keep_ssa = 1;
    } else if (strcmp("-unique-ssavars", argv[i]) == 0) {
      enable_unique_ssavars = 1;
    } else if (strcmp("-ra", argv[i]) == 0) {
      enable_ra = 1;
    } else if (strcmp("-linear-scan", argv[i]) == 0) {
      use_lsra = 1;
    } else if (strcmp("-limit-nacs", argv[i]) == 0) {
      enable_limit_nacs = 1;
    } else if (strcmp("-emit-nac", argv[i]) == 0) {
      enable_emit_nac = 1;
    } else if (strcmp("-emit-ansic", argv[i]) == 0) {
      enable_emit_ansic = 1;
    } else if (strcmp("-emit-cfg", argv[i]) == 0) {
      enable_emit_cfg = 1;
    } else if (strcmp("-dump-varnum-nac", argv[i]) == 0) {
      dump_varnum_nac = 1;
    } else if (strcmp("-dump-phiins-nac", argv[i]) == 0) {
      dump_phiins_nac = 1;
    } else if (strcmp("-dump-phimin-nac", argv[i]) == 0) {
      dump_phimin_nac = 1;
    } else if (strcmp("-dump-phielm-nac", argv[i]) == 0) {
      dump_phielm_nac = 1;
    } else if (strcmp("-dump-simdce-nac", argv[i]) == 0) {
      dump_simdce_nac = 1;
    } else if (strcmp("-dump-ra-nac", argv[i]) == 0) {
      dump_ra_nac = 1;
    } else if (strcmp("-dump-tgf", argv[i]) == 0) {
      dump_tgf = 1;
    } else if (strcmp("-dump-arg", argv[i]) == 0) {
      dump_arg = 1;
    } else if (strcmp("-dump-grh", argv[i]) == 0) {
      dump_grh = 1;
    } else if (strcmp("-dump-poset", argv[i]) == 0) {
      dump_poset = 1;
    } else if (strcmp("-gcc", argv[i]) == 0) {
      enable_gcc  = 1;
      enable_llvm = 0;
    } else if (strcmp("-llvm", argv[i]) == 0) {
      enable_gcc  = 0;
      enable_llvm = 1;
    } else if (strcmp("-flp", argv[i]) == 0) {
      enable_flp  = 1;
    } else {
      if (argv[i][0] != '-') {
        if (copied_nac_file_name==0) {
          strcpy(nac_file_name, argv[i]);
          copied_nac_file_name = 1;
        } else {
          print_usage();
          exit(1);
        }
      }
    }
  }

  /* infile (argv[1]) is passed as input to the nac parser. */
  if (copied_nac_file_name == 0) {
    print_usage();
    exit(1);
  } else {
    nacin = fopen(nac_file_name, "r");
  }

  /* Reporting the invocation options for the current run of "cdfg2hdl". */
  fprintf(stdout, "### nac2cdfg started operation. ###\n");  
  fprintf(stdout, "Info: Options used in the current run of \"nac2cdfg\":\n");
  fprintf(stdout, "Info: nac_file_name=%s\n", nac_file_name);  
  fprintf(stdout, "Info: enable_debug=%d\n", enable_debug);
  fprintf(stdout, "Info: enable_force_data_types=%d\n", enable_force_data_types);
  fprintf(stdout, "Info: enable_permissive=%d\n", enable_permissive);
  fprintf(stdout, "Info: enable_flp=%d\n", enable_flp);
  fprintf(stdout, "Info: enable_ssa=%d\n", enable_ssa);
  fprintf(stdout, "Info: enable_emit_cfg=%d\n", enable_emit_cfg);
  fprintf(stdout, "Info: enable_emit_nac=%d\n", enable_emit_nac);
  fprintf(stdout, "Info: enable_emit_ansic=%d\n", enable_emit_ansic);
  fprintf(stdout, "Info: enable_dce=%d\n", enable_dce);
  fprintf(stdout, "Info: enable_keep_ssa=%d\n", enable_keep_ssa);
  fprintf(stdout, "Info: enable_limit_nacs=%d\n", enable_limit_nacs);
  fprintf(stdout, "Info: nac_count=%d\n", nac_count);
  fprintf(stdout, "Info: use_pseudo_ssa=%d\n", use_pseudo_ssa);
  fprintf(stdout, "Info: enable_phi_bbs=%d\n", enable_phi_bbs);
  fprintf(stdout, "Info: enable_unique_ssavars=%d\n", enable_unique_ssavars);
  fprintf(stdout, "Info: dump_varnum_nac=%d\n", dump_varnum_nac);
  fprintf(stdout, "Info: dump_phiins_nac=%d\n", dump_phiins_nac);
  fprintf(stdout, "Info: dump_phimin_nac=%d\n", dump_phimin_nac);
  fprintf(stdout, "Info: dump_phielm_nac=%d\n", dump_phielm_nac);
  fprintf(stdout, "Info: dump_simdce_nac=%d\n", dump_simdce_nac);
  fprintf(stdout, "Info: dump_tgf=%d\n", dump_tgf);
  fprintf(stdout, "Info: dump_arg=%d\n", dump_arg);
  fprintf(stdout, "Info: dump_grh=%d\n", dump_grh);
  fprintf(stdout, "Info: dump_poset=%d\n", dump_poset);
  fprintf(stdout, "Info: use_appel=%d\n", use_appel);
  fprintf(stdout, "Info: enable_opt_spbb=%d\n", enable_opt_spbb);
  fprintf(stdout, "Info: enable_ra=%d\n", enable_ra);
  fprintf(stdout, "Info: use_lsra=%d\n", use_lsra);
  fprintf(stdout, "Info: dump_ra_nac=%d\n", dump_ra_nac);
  fprintf(stdout, "Info: enable_gcc=%d\n", enable_gcc);
  fprintf(stdout, "Info: enable_llvm=%d\n", enable_llvm);  
  fprintf(stdout, "### nac2cdfg completed operation. ###\n");  

  return 0;
}
