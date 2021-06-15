set term pdf
set output "phon_comp.pdf"
plot "../phonon/pb.freq.gp" u 1:2 pt 2 ps 0.5 title "matdyn.x", \
  "" u 1:3 pt 2 ps 0.5 notitle, \
  "" u 1:4 pt 2 ps 0.5 notitle, \
  "epwphon.dat" u 1:($2*8.06555) w l title "EPW"
