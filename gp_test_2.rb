def gnuplot(commands)
  IO.popen("gnuplot", "w") { |io| io.puts commands }
end

commands = %Q(
  set terminal canvas standalone
  set output "gp_canvas_test.html"
  plot [-10:10] sin(x), atan(x), cos(atan(x))
)
gnuplot(commands)