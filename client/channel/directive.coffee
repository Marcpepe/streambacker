angular.module '%module%.channel'
  .directive 'channelViews', ->
    # controller: 'ChannelController'
    link: ($scope) ->
      margin =
        top: 50
        right: 20
        bottom: 30
        left: 80
      width = 960 - margin.left - margin.right
      height = 500 - margin.top - margin.bottom
      parseDate = d3.time.format('%Y-%m-%dT%H:%M:%S.%LZ').parse
      x = d3.time.scale()
        .range [
          0
          width
        ]
      y = d3.scale.linear()
        .range [
          height
          0
        ]
      xAxis = d3.svg.axis()
        .scale x
        .orient 'bottom'
      yAxis = d3.svg.axis()
        .scale y
        .orient 'left'
      line = d3.svg.line()
        .x (d) ->
          x d.createdAt
        .y (d) ->
          y d.viewers

      svg = d3.select '#channel-views-chart'
              .append 'svg'
              .attr 'width', width + margin.left + margin.right
              .attr 'height', height + margin.top + margin.bottom
              .append 'g'
              .attr 'transform', 'translate(' + margin.left + ',' + margin.top + ')'


      data = $scope.streamStamps

      data.forEach (d) ->
        d.createdAt = parseDate d.createdAt

      x.domain d3.extent data, (d) ->
        d.createdAt
      y.domain d3.extent data, (d) ->
        d.viewers

      svg.append 'g'
          .attr 'class', 'x axis'
          .attr 'transform', 'translate(0,' + height + ')'
          .call xAxis

      svg.append 'g'
          .attr 'class', 'y axis'
          .call yAxis
        .append 'text'
          .attr 'transform', 'rotate(-90)'
          .attr 'y', 6
          .attr 'dy', '.71em'
          .style 'text-anchor', 'end'
          .text 'Viewers'

      svg.append 'text'
        .attr 'x', (width/2)
        .attr 'y', 0 - (margin.top/2)
        .attr 'text-anchor', 'middle'
        .style 'font-size', '16px'
        .style 'font-weight', 'bold'
        .text new Date(data[0].stream.createdAt).toDateString()

      svg.append "path"
          .datum data
          .attr "class", "line"
          .attr "d", line
