set term pdf
set output "wannier_bands.pdf"
set style data dots
set nokey
set xrange [0: 5.69510]
set yrange [ -6.97701 : 19.79062]
set arrow from  1.26915,  -6.97701 to  1.26915,  19.79062 nohead
set arrow from  1.90372,  -6.97701 to  1.90372,  19.79062 nohead
set arrow from  2.80114,  -6.97701 to  2.80114,  19.79062 nohead
set arrow from  3.90025,  -6.97701 to  3.90025,  19.79062 nohead
set xtics ("G"  0.00000,"X"  1.26915,"W"  1.90372,"L"  2.80114,"G"  3.90025,"K"  5.69510)
 plot "ex3_band.dat"
