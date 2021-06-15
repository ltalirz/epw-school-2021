
`/phonon` directory
```
export OMP_NUM_THREADS=1
mpirun -np 4 pw.x -nk 4 -in pb.scf.in | tee pb.scf.out
mpirun -np 4 ph.x -nk 4 -in pb.ph.in | tee pb.ph.out

q2r.x -in q2r.in | tee q2r.out
matdyn.x -in matdyn.in | tee matdyn.out

./pp.py
Enter the prefix used for PH calculations (e.g. diam)
pb
```

`/band` directory
```
mkdir pb.save
cp ../phonon/pb.save/charge-density.dat pb.save/
cp ../phonon/pb.save/data-file-schema.xml pb.save/

mpirun -np 4 pw.x -nk 4 -in pb.band.in | tee pb.band.out
bands.x -in pb.bands.in | tee pb.bands.out
```

`/epw` directory
```
mkdir pb.save
cp ../phonon/pb.save/charge-density.dat pb.save/
cp ../phonon/pb.save/data-file-schema.xml pb.save/

mpirun -np 4 pw.x -nk 4 -in pb.nscf.in | tee  pb.nscf.out
mpirun -np 4 epw.x -nk 4 -in pb.epw1.in | tee  pb.epw1.out

open -a Vesta.app pb_00003.cube


plotband.x
     Input file > band.eig
Reading    4 bands at    181 k-points
Range:   -0.4085   19.0142eV  Emin, Emax, [firstk, lastk] > -1,20
high-symmetry point:  0.0000 0.0000 0.0000   x coordinate   0.0000
high-symmetry point: -1.0000 0.0000 0.0000   x coordinate   1.0000
high-symmetry point: -1.0000 0.5000 0.0000   x coordinate   1.5000
high-symmetry point: -0.5000 0.5000 0.5000   x coordinate   2.2071
high-symmetry point:  0.5333 1.5000-0.4833   x coordinate   2.2071
high-symmetry point:  1.5000 1.5000 0.0000   x coordinate   3.2879
high-symmetry point:  0.0000 0.0000 0.0000   x coordinate   5.4092
high-symmetry point:  0.5000 1.5000-0.5000   x coordinate   7.0675
output file (gnuplot/xmgr) > epwband.dat

 plotband.x
     Input file > phband.freq
Reading    3 bands at    181 k-points
Range:    0.0000   13.8671eV  Emin, Emax, [firstk, lastk] > 0,14
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

gnuplot decay_comp.gnu
open decay_comp.pdf

mpirun -np 4 epw.x -nk 4 -in pb.epw2.in | tee  pb.epw2.out
```

## Missing

 * [`pp.py`](https://gitlab.com/QEF/q-e/-/raw/develop/EPW/bin/pp.py)


## Learnings

 * `.dynX` files contain dynamical matrix at different q points
 * `.dvscfX` files (in `_ph0`) contain derivative of potential with respect to q vector at different q points
 * It's safer to use a `pw.x` `bands` calculation as input to EPW (for special cases, even when specifying a 10x10x10 k-point grid for `nscf`, `pw.x` computes additional k-points which can confuse EPW).
   Note: The only difference between a `bands` and a `nscf` calculation in this case is that `bands` does not compute the band width and the Fermi energy.
 * Essentially the full input of Wannier90 is reproduced (in a somewhat clunky way) in the EPW input file, including projectors etc.
 * Decay:
   * Hamiltonian decayed by factor of 10 for 3 Angstroms
   * Dynamical matrix decayed by factor of 10 for 3.5 Angstrom
   * el-ph vertex decayed by factor of 10 for 4.2 Angstrom in electronic coordinate
   * el-ph vertex decayed by factor of 10 for ~4 Angstrom in phonon coordinates
   Decay rates are quite similar in the electronic and phonon coordinates, however because we only have a 3x3x3 q-point grid, we're truncating already at ~6 Angstroms (aim for truncating not more than 1e-4)
 * Interpolation of electron-phonon matrix elements by default only occurs for electronic states within a small energy window (e.g. `fsthick`=1eV) around the Fermi energy. 
   Electronic states several phonon energies away from the Fermi energy would need to scatter multiple times to contribut to the line-width
 * A "fine" grid would e.g. be 20x20x20
 * Looking at the phonon linewidth as a function of the wave vector q, it seems that it is highest when the phonon energy is highest (which makes sense - I guess then there are more electronic states available for scattering)
 

Open questions:
 * Band structure seems to have been plotted along different path for EPW
