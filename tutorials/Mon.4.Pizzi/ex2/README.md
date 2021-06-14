```
# Note: using many threads seems to be super inefficient
export OMP_NUM_THREADS=1 

mpirun -np 1 pw.x -in 05_nscf.in | tee 05_nscf.out
wannier90.x -pp ex2
pw2wannier90.x -in 06_pw2wan.in | tee 06_pw2wan.out
wannier90.x ex2

gnuplot bands_comp.gnu
open -a Vesta.app ex2_00001.xsf
```


# Missing

 * `bands_comp.gnu`
```
set term pdf
set output "bands_comp.pdf"
set xtics nomirr
set x2tics
set xrange [*:*] noextend
set x2range [*:*] noextend
plot 'qebands.agr' w l, 'ex2_band.dat' axes x2y1 w l
```


# Learnings

 * `dis_win_max` should include the bands of the "right character"
 * `dis_froz_max`: which bands to include unchanged (no disentanglement needed)
 * When using disentanglement, always check that it converges, that the wave functions are real (`Maximum Im/Re Ratio`) and that the bands are reproduced well
 * Increasing the k-point sampling from 4x4x4 to 6x6x6 improved interpolation a little bit but not substantially (2nd conduction band still deviates by ~2eV (!))
