```
# Note: using many threads seems to be super inefficient
export OMP_NUM_THREADS=1 
mpirun -np 1 pw.x -in 01_scf.in | tee 01_scf.out
mpirun -np 1 pw.x -in 02_bands.in | tee 02_bands.out
mpirun -np 1 bands.x -in 03_bandsx.in | tee 03_bandsx.out

plotband.x
     Input file > bands.dat
Reading   12 bands at    101 k-points
Range:   -5.6990   20.5850eV  Emin, Emax, [firstk, lastk] > -5,20
high-symmetry point: -0.3536 0.3536 0.3536   x coordinate   0.0000
high-symmetry point:  0.0000 0.0000 0.0000   x coordinate   0.6124
high-symmetry point: -0.7071 0.0000 0.0000   x coordinate   1.3195
output file (gnuplot/xmgr) > qebands.plt
bands in gnuplot/xmgr format written to file qebands.plt
output file (ps) > qebands.ps
Efermi > 5.8
deltaE, reference E (for tics) 2 5.8
bands in PostScript format written to file qebands.ps

mpirun -np 1 pw.x -in 05_nscf.in | tee 05_nscf.out
wannier90.x -pp ex1
pw2wannier90.x -in 06_pw2wan.in | tee 06_pw2wan.out
wannier90.x ex1

gnuplot ex1_bands.gnu
open -a Vesta.app ex1_00001.xsf
```


# Missing

This is part of Wannier90 and needs to be downloaded when it is installed via QE

 * [kmesh.pl](https://raw.githubusercontent.com/wannier-developers/wannier90/develop/utility/kmesh.pl)

 * `bands_comp.gnu`
```
set term pdf
set output "bands_comp.pdf"
set xtics nomirr
set x2tics
set xrange [*:*] noextend
set x2range [*:*] noextend
plot 'qebands.agr' w l, 'ex1_band.dat' axes x2y1 w l
```


# Learnings

 * The projections are *bond-centered* s-orbitals... hm
 * Wannier90 does not print to stdout
 * Watch convergence with `grep DLTA ex1.wout`
 * Search for `Final State` to see wannier centers + spread
 * 4x4x4 k-point mesh not good enough here;
   increasing it should give a better match
 * For a calculation in a 4x4x4 k-point mesh you will get Wannier functions defined in a 4x4x4 supercell

To check for good Wannierisation:
 * realness of Wannier functions
 * band interpolation
