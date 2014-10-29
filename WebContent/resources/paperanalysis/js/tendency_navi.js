$(function () {
        $('#container4').highcharts({
            chart: {
                type: 'column',
                margin: [ 50, 50, 100, 80]
            },
            title: {
                text: 'ÈÈµã´Ê»ãÍ³¼Æ'
            },
            xAxis: {
                categories: [
                    'Âé»Æ',
                    '¹ðÖ¦',
                    '¹ðÖ¦',
                    'Âé»Æ',
                    '¹ðÖ¦',
                    'Âé»Æ',
                    '¹ðÖ¦',
                    'Âé»Æ',
                    '¹ðÖ¦',
                    'Âé»Æ',
                    '¹ðÖ¦',
                    'Âé»Æ',
                    '¹ðÖ¦',
                    'Âé»Æ',
                    '¹ðÖ¦',
                    'Âé»Æ',
                    '¹ðÖ¦',
                    'Âé»Æ',
                    'Shenzhen',
                    'Âé»Æ'
                ],
                labels: {
                    rotation: -45,
                    align: 'right',
                    style: {
                        fontSize: '13px',
                        fontFamily: 'Verdana, sans-serif'
                    }
                }
            },
            yAxis: {
                min: 0,
                title: {
                    text: 'ÒýÓÃ´ÎÊý (Æª)'
                }
            },
            legend: {
                enabled: false
            },
            tooltip: {
                pointFormat: 'Population in 2008: <b>{point.y:.1f} millions</b>',
            },
            series: [{
                name: 'Population',
                data: [34.4, 21.8, 20.1, 20, 19.6, 19.5, 19.1, 18.4, 18,
                    17.3, 16.8, 15, 14.7, 14.5, 13.3, 12.8, 12.4, 11.8,
                    11.7, 11.2],
                dataLabels: {
                    enabled: true,
                    rotation: -90,
                    color: '#FFFFFF',
                    align: 'right',
                    x: 4,
                    y: 10,
                    style: {
                        fontSize: '13px',
                        fontFamily: 'Verdana, sans-serif',
                        textShadow: '0 0 3px black'
                    }
                }
            }]
        });
    });
    
