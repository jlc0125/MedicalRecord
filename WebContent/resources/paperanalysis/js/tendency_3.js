$(function () {
        $('#container3').highcharts({
            chart: {
                type: 'line'
            },
            title: {
                text: '年度投稿命中率'
            },
            subtitle: {
                text: '中草药文献分析系统'
            },
            xAxis: {
                categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec']
            },
            yAxis: {
                title: {
                    text: '文章数量 (篇)'
                }
            },
            tooltip: {
                enabled: false,
                formatter: function() {
                    return '<b>'+ this.series.name +'</b><br/>'+
                        this.x +': '+ this.y +'°C';
                }
            },
            plotOptions: {
                line: {
                    dataLabels: {
                        enabled: true
                    },
                    enableMouseTracking: false
                }
            },
            series: [{
                name: '投稿篇数',
                data: [7, 69, 95, 14, 18, 21, 25, 26, 23, 18, 13, 9]
            }, {
                name: '命中篇数',
                data: [3, 42, 57, 8, 11, 15, 17, 16, 14, 10, 6, 8]
            }]
        });
    });
    
