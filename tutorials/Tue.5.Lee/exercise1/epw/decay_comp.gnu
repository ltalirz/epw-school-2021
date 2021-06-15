set term pdf
set output "decay_comp.pdf"

set logscale y
set pointsize 0.5

plot "decay.H" u 1:2 w p pt 7
plot "decay.dynmat" u 1:2 w p pt 7
plot "decay.epmate" u 1:2 w p pt 7
plot "decay.epmatp" u 1:2 w p pt 7
