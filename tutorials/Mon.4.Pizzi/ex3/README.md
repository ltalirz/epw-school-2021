```
# Note: using many threads seems to be super inefficient
export OMP_NUM_THREADS=1 
mpirun -np 1 pw.x -in 01_scf.in | tee 01_scf.out
#mpirun -np 1 pw.x -in 02_bands.in | tee 02_bands.out
#mpirun -np 1 bands.x -in 03_bandsx.in | tee 03_bandsx.out

mpirun -np 1 pw.x -in 04_nscf.in | tee 04_nscf.out
wannier90.x -pp ex3
pw2wannier90.x -in 05_pw2wan.in | tee 05_pw2wan.out
wannier90.x ex3

# Visualize either using XCrysden or Fermi Surfer
# http://fermisurfer.osdn.jp/en/_build/html/install.html
open -a Vesta.app ex1_00001.xsf

gnuplot ex3_band.gnu
```

Note: Skipped the "further ideas" due to time constraints


# Missing

xcrysden / Fermi Surfer

# Learnings

 * `dis_froz_max`: maximum energy until you hit a band that is not one you want (and will need to be removed in disentanglement)
 * BXSF format (bands-XSF; specifically for Fermi surfaces) not supported by Vesta
 * Might be interesting to look into conda-forge feedstocks for xcrysden (GPL) and [fermi surfer](https://osdn.net/projects/fermisurfer/scm/git/fermisurfer/tree/master/) ([MIT](https://osdn.net/projects/fermisurfer/scm/git/fermisurfer/blobs/master/doc/en/copy.rst))
