* Encoding: UTF-8.

DATASET ACTIVATE DataSet1.
* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=horsepower price engine_size body make 
    MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FITLINE TOTAL=NO SUBGROUP=NO.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: horsepower=col(source(s), name("horsepower"))
  DATA: price=col(source(s), name("price"))
  DATA: engine_size=col(source(s), name("engine_size"))
  DATA: body=col(source(s), name("body"), unit.category())
  DATA: make=col(source(s), name("make"), unit.category())
  GUIDE: axis(dim(1), label("horsepower"))
  GUIDE: axis(dim(2), label("price"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("body"))
  GUIDE: text.title(label("Grouped 3-D Scatter of price by horsepower by engine_size..."))
  SCALE: linear(dim(1), max(200))
  SCALE: linear(dim(2), min(0))
  ELEMENT: point(position(horsepower*price), color.interior(body), label(make), size(engine_size))
END GPL.


DATASET ACTIVATE DataSet1.
* Chart Builder.
GGRAPH
  /GRAPHDATASET NAME="graphdataset" VARIABLES=horsepower price engine_size body make 
    MISSING=LISTWISE REPORTMISSING=NO
  /GRAPHSPEC SOURCE=INLINE
  /FITLINE TOTAL=YES.
BEGIN GPL
  SOURCE: s=userSource(id("graphdataset"))
  DATA: horsepower=col(source(s), name("horsepower"))
  DATA: price=col(source(s), name("price"))
  DATA: engine_size=col(source(s), name("engine_size"))
  DATA: body=col(source(s), name("body"), unit.category())
  DATA: make=col(source(s), name("make"), unit.category())
  GUIDE: axis(dim(1), label("horsepower"))
  GUIDE: axis(dim(2), label("price"))
  GUIDE: legend(aesthetic(aesthetic.color.interior), label("body"))
  GUIDE: text.title(label("Bubble chart of price by horsepower by engine_size"))
  SCALE: linear(dim(1), max(200))
  SCALE: linear(dim(2), min(0))
  SCALE: linear(aesthetic(aesthetic.size), aestheticMinimum(size."10px"), aestheticMaximum(size."30px"))
  ELEMENT: point(position(horsepower*price), color.interior(body), label(make), size(engine_size))
END GPL.





