require 'gnuplot'

Gnuplot.open do |gp|
  Gnuplot::Plot.new( gp ) do |plot|
    plot.terminal "canvas standalone"
    plot.output   "gp_canvas_test.html"
    
    plot.xrange "[-10:10]"
    plot.title  "Sin Wave Example"
    plot.ylabel "x"
    plot.xlabel "sin(x)"
    
    plot.data << Gnuplot::DataSet.new( "sin(x)" ) do |ds|
      ds.with = "lines"
      ds.linewidth = 4
    end
    
    # plot.output
  end
end