# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

Chart.defaults.global.responsive = true;

jQuery ->
  canvas = document.getElementById("summary-chart")
  if canvas and ctx = canvas.getContext("2d")
    pieChart = new Chart(ctx).Pie(
      data, {
        animateScale : true,
        showScale: false,
        legendTemplate : """
          <ul>
             <% [2, 0, 1].forEach(function(i) { %>
               <li>
                 <span class="badge <%= data[i].label.toLowerCase() %>"><%= data[i].value %></span>
                 <label><%= data[i].label %></label>
             </li>
           <% }); %>
          </ul>
        """
      }
    )
    legend = pieChart.generateLegend()
    $('.legend').append(legend)
