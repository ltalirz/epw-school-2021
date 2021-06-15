```
# Note: using many threads seems to be super inefficient
export OMP_NUM_THREADS=1 
mpirun -np 1 pw.x -in 01_scf.in | tee 01_scf.out
mpirun -np 1 pw.x -in 02_bands.in | tee 02_bands.out
mpirun -np 1 bands.x -in 03_bandsx.in | tee 03_bandsx.out

mpirun -np 1 pw.x -in 04_nscf.in | tee 04_nscf.out
wannier90.x -pp ex4
projwfc.x -in 05_proj.in | tee proj.out
./generate_weights.sh

pw2wannier90.x -in 06_pw2wan.in | tee 06_pw2wan.out
wannier90.x ex4

gnuplot bands_comp.gnu
```

Note: Skipped determination of mu and sigma due to time constraints

# Learnings

 * SCDM is not fully automatized (need to fit error function to "projectability" vs energy
 * Results of interpolation are impressive
