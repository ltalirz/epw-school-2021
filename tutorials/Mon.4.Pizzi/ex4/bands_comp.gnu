set term pdf
set output "bands_comp.pdf"
set xtics nomirr
set x2tics
set xrange [*:*] noextend
set x2range [*:*] noextend
plot 'bands.dat.gnu' w l, 'ex4_band.dat' axes x2y1 w l
