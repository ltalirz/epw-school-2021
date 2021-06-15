set term pdf
set output "g_comp.pdf"
set pointsize 0.5
plot "data.epw" u 7 pt 6 lc rgb "black" title "EPW"
