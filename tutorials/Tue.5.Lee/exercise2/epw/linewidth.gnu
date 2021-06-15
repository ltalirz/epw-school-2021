set term pdf
set output "linewidth.pdf"
plot "linewidth.elself.20.000K" u 1:4 every 3::2 w lp
