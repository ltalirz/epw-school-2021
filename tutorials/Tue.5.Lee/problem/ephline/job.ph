#!/bin/bash
#SBATCH -J myjob           # Job name
#SBATCH -p small    # Queue (partition) name
#SBATCH -N 1               # Total # of nodes 
#SBATCH --ntasks-per-node 36
#SBATCH -t 01:00:00        # Run time (hh:mm:ss)
#SBATCH -A EPW-SCHOOL
#SBATCH --reservation=EPW-SCHOOL-06-15-2021

module list
pwd
date

# Launch MPI code... 
export PATHQE=/work2/06868/giustino/EPW-SCHOOL/q-e

ibrun $PATHQE/bin/pw.x -nk 18 -in sic.scf.in > sic.scf.out
ibrun $PATHQE/test-suite/not_epw_comp/ph.x -nk 18 -in sic.ephline.in > sic.ephline.out

date
