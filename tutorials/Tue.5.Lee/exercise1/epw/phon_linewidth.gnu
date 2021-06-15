set term pdf
set output "phon_linewidth.pdf"
plot "linewidth.phself.0.075K" u 1:4 every 3::2 w l lw 2 ,\
  "" u 1:4 every 3::1 w l lw 2, \
  "" u 1:4 every 3::0 w l lw 2 
