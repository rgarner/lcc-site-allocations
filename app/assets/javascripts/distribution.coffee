Chart.defaults.global.responsive = true;

jQuery ->
  canvas = document.getElementById("distribution-chart")
  if canvas and ctx = canvas.getContext("2d")
    lineChart = new Chart(ctx).Line(
      data, {
        scaleShowGridLines : true,
        scaleLabel: " <%=value%>",
        bezierCurve: false,
        pointDotRadius: 2,
      }
    )
