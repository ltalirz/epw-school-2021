`/ephline` directory
```
mpirun -np 4 pw.x -nk 4 -in sic.scf.in | tee sic.scf.out

# Note: the following run took 10 minutes
#mpirun -np 4 ph.x -nk 4 -in sic.ephline.in | tee sic.ephline.out
```


`/epw` directory
```
export OMP_NUM_THREADS=1

mkdir sic.save
cp ../ephline/sic.save/charge-density.dat sic.save/
cp ../ephline/sic.save/data-file-schema.xml sic.save/

mpirun -np 4 pw.x -nk 4 -in sic.nscf.in | tee sic.nscf.out
mpirun -np 4 epw.x -nk 4 -in sic.epw1.in | tee sic.epw1.out

grep "4        4        6" sic.epw1.out > data.epw
gnuplot g_comp.gnu
open g_comp.pdf
```

## Missing

 * modified `ph.x` version from [`test-suite/not_epw_comp`](https://gitlab.com/QEF/q-e/-/tree/develop/test-suite/not_epw_comp)

## Learnings
