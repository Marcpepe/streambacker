angular.module '%module%.channel'
  .directive 'channelViews', ->
    controller: 'ChannelController'
    link: ($scope) ->
      console.log 'my data : ', $scope.streamStamps
      svg = d3.select '#channel-views-chart'
      margin =
        top: 20
        right: 20
        bottom: 30
        left: 50
      width = 960 - (margin.left) - (margin.right)
      height = 500 - (margin.top) - (margin.bottom)
      parseDate = d3.time.format('%d-%b-%y').parse
      x = d3.time.scale().range([
        0
        width
      ])
      y = d3.scale.linear().range([
        height
        0
      ])
      xAxis = d3.svg.axis().scale(x).orient('bottom')
      yAxis = d3.svg.axis().scale(y).orient('left')
      line = d3.svg.line().x((d) ->
        x d.date
      ).y((d) ->
        y d.close
      )
      svg = d3.select('body').append('svg').attr('width', width + margin.left + margin.right).attr('height', height + margin.top + margin.bottom).append('g').attr('transform', 'translate(' + margin.left + ',' + margin.top + ')')
      svg = d3.select("body").append("svg")
        .attr("width", width + margin.left + margin.right)
        .attr("height", height + margin.top + margin.bottom)
      .append("g")
        .attr("transform", "translate(" + margin.left + "," + margin.top + ")");

      # data = $scope.streamStamps
      node = svg.
      x.domain d3.extent data, (d) ->
        d.updated_at
      y.domain d3.extent data, (d) ->
        d.viewers

      svg.append("g")
          .attr("class", "x axis")
          .attr("transform", "translate(0," + height + ")")
          .call(xAxis);

      svg.append("g")
          .attr("class", "y axis")
          .call(yAxis)
        .append("text")
          .attr("transform", "rotate(-90)")
          .attr("y", 6)
          .attr("dy", ".71em")
          .style("text-anchor", "end")
          .text("Price ($)");

      svg.append("path")
          .datum(data)
          .attr("class", "line")
          .attr("d", line);
