set term pdf
set output "bands_comp.pdf"
plot "../band/bands.out.gnu" u 1:2 w l title "pw.x", "epwband.dat" u ($1*0.6875):2 pt 2 title "EPW"
