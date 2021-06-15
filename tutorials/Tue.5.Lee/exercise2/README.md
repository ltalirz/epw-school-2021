`/phonon` directory
```
export OMP_NUM_THREADS=1
mpirun -np 4 pw.x -nk 4 -in sic.scf.in | tee sic.scf.out
mpirun -np 4 ph.x -nk 4 -in sic.ph.in | tee sic.ph.out

q2r.x -in q2r.in | tee q2r.out
matdyn.x -in matdyn.in | tee matdyn.out

./pp.py
Enter the prefix used for PH calculations (e.g. diam)
sic
```

`/epwline` directory
```
mpirun -np 4 pw.x -nk 4 -in sic.scf.in | tee sic.scf.out
# Note: the following run took 10 minutes
mpirun -np 4 ph.x -nk 4 -in sic.ephline.in | tee sic.ephline.out

# this doesn't work (need modified ph.x executable)
grep "4        4        6" sic.ephline.out

```


`/band` directory
```
mkdir sic.save
cp ../phonon/sic.save/charge-density.dat sic.save/
cp ../phonon/sic.save/data-file-schema.xml sic.save/

mpirun -np 4 pw.x -nk 4 -in sic.band.in | tee sic.band.out
bands.x -in sic.bands.in | tee sic.bands.out
```

`/epw` directory
```
mkdir sic.save
cp ../phonon/sic.save/charge-density.dat sic.save/
cp ../phonon/sic.save/data-file-schema.xml sic.save/

mpirun -np 4 pw.x -nk 4 -in sic.nscf.in | tee  sic.nscf.out
mpirun -np 4 epw.x -nk 4 -in sic.epw1.in | tee  sic.epw1.out

grep "4        4        6" sic.epw1.out > data.epw
gnuplot g_comp.gnu
open g_comp.pdf

mpirun -np 4 epw.x -nk 4 -in sic.epw2.in | tee  sic.epw2.out

plotband.x
     Input file > band.eig
Reading    4 bands at    181 k-points
Range:   -6.1066    9.3594eV  Emin, Emax, [firstk, lastk] > -7,10  4
high-symmetry point:  0.0000 0.0000 0.0000   x coordinate   0.0000
high-symmetry point: -1.0000 0.0000 0.0000   x coordinate   1.0000
high-symmetry point: -1.0000 0.5000 0.0000   x coordinate   1.5000
high-symmetry point: -0.5000 0.5000 0.5000   x coordinate   2.2071
high-symmetry point:  0.5333 1.5000-0.4833   x coordinate   2.2071
high-symmetry point:  1.5000 1.5000 0.0000   x coordinate   3.2879
high-symmetry point:  0.0000 0.0000 0.0000   x coordinate   5.4092
high-symmetry point:  0.5000 1.5000-0.5000   x coordinate   7.0675
output file (gnuplot/xmgr) > epwband.dat
bands in gnuplot/xmgr format written to file epwband.dat

plotband.x
     Input file > phband.freq
Reading    6 bands at    181 k-points
Range:    0.0000  116.3076eV  Emin, Emax, [firstk, lastk] > 0,117
high-symmetry point:  0.0000 0.0000 0.0000   x coordinate   0.0000
high-symmetry point: -1.0000 0.0000 0.0000   x coordinate   1.0000
high-symmetry point: -1.0000 0.5000 0.0000   x coordinate   1.5000
high-symmetry point: -0.5000 0.5000 0.5000   x coordinate   2.2071
high-symmetry point: -0.7500 0.7500 0.0000   x coordinate   2.8195
high-symmetry point:  0.0000 0.0000 0.0000   x coordinate   3.8801
high-symmetry point: -0.5000 0.5000 0.5000   x coordinate   4.7462
output file (gnuplot/xmgr) > epwphon.dat
bands in gnuplot/xmgr format written to file epwphon.dat


gnuplot bands_comp.gnu
open bands_comp.pdf

gnuplot phon_comp.gnu
open phon_comp.pdf

mpirun -np 4 epw.x -nk 4 -in sic.epw3.in | tee  sic.epw3.out

gnuplot linewidth.gnu
open linewidth.pdf

```

## Missing

 * [`pp.py`](https://gitlab.com/QEF/q-e/-/raw/develop/EPW/bin/pp.py)
 * modified `ph.x` version from [`test-suite/not_epw_comp`](https://gitlab.com/QEF/q-e/-/tree/develop/test-suite/not_epw_comp)


## Learnings

 * If necessary, `pp.x` output will automatically compute the response of the system to a (finite) electric field to get the Born-effective charges (search for `Effective`).
   This determines the splitting between LO and TO phonons
 * el-ph matrix elements are gauge dependent.
   A gauge-invariant average of their norm over degenerate subspaces of bands and modes is performed (?)
 * phonon linewidths in SiC are quite substantial: ~80meV for the valence band
