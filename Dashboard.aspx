<%@ Page Title="" Language="C#" MasterPageFile="~/Mainmaster.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <marquee onmouseover="this.stop();" onmouseout="this.start();"><asp:Label ID="lbl_birth" runat="server"></asp:Label></marquee>
    <div class="content container-fluid">
        <div class="row">
            <div class="col-md-6 col-sm-6 col-lg-6 col-xl-3">
                <div class="dash-widget clearfix card-box">
                    <span class="dash-widget-icon"><i class="fa fa-user"></i></span>
                    <div class="dash-widget-info">
                        <h3>
                            <asp:Label runat="server" ID="lbl_employee"></asp:Label></h3>
                        <span style="float: right">Employees</span>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-sm-6 col-lg-6 col-xl-3">
                <div class="dash-widget clearfix card-box">
                    <span class="dash-widget-icon"><i class="fa fa-thumbs-up"></i></span>
                    <div class="dash-widget-info">
                        <h3>
                            <asp:Label runat="server" ID="lbl_auhtnenticate"></asp:Label></h3>
                        <span style="float: right">Aadhar Authenticated</span>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-sm-6 col-lg-6 col-xl-3">
                <div class="dash-widget clearfix card-box">
                    <span class="dash-widget-icon"><i class="fa fa-thumbs-down"></i></span>
                    <div class="dash-widget-info">
                        <h3>
                            <asp:Label runat="server" ID="lbl_notauthenticate"></asp:Label></h3>
                        <span style="float: right">Yet to be Authenticated</span>
                    </div>
                </div>
            </div>
            <div class="col-md-6 col-sm-6 col-lg-6 col-xl-3">
                <div class="dash-widget clearfix card-box">
                    <span class="dash-widget-icon"><i class="fa fa-users"></i></span>
                    <div class="dash-widget-info">
                        <h3>
                            <asp:Label runat="server" ID="lbl_vendor"></asp:Label></h3>
                        <span style="float: right">Vendors</span>
                    </div>
                </div>
            </div>
        </div>
        <%--<div class="row">
            <div class="col-lg-12">
                <div class="card-box">
                    <canvas id="bar-chart" width="400" height="100"></canvas>
                </div>
                <script>
                    // Return with commas in between
                   
                  
                </script>
            </div>
        </div>--%>

        <div class="row">
            <div class="col-lg-12">
                <div class="card-box">
                    <%--<h3 class="card-title">Total Revenue</h3>--%>
                    <canvas id="barChart" width="400" height="75"></canvas>
                    <script>
                        //bar
                        function getvendorbarchart(label, data) {
                            var ctxB = document.getElementById("barChart").getContext('2d');
                            var myBarChart = new Chart(ctxB, {
                                type: 'bar',
                                data: {
                                    labels: label,
                                    datasets: [{
                                        label: 'Vendor wise Employee Count',
                                        data: data,
                                        backgroundColor: [
                                          'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                         'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                           'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                           'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                           'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                           'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                        ],
                                        borderColor: [
                                          'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                         'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                           'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                           'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                           'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                           'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                        ],
                                        borderWidth: 1
                                    }]
                                },
                                options: {
                                    scales: {
                                        yAxes: [{
                                            ticks: {
                                                fontSize: 12,
                                            },
                                            gridLines: {
                                                color: "rgba(0, 0, 0, 0)",
                                            }
                                        }],
                                        xAxes: [{
                                            ticks: {
                                                fontSize: 9,
                                                fontStyle: 'bold',
                                            }, gridLines: {
                                                color: "rgba(0, 0, 0, 0)",
                                            }
                                        }]
                                    }
                                }
                            });
                        }

                    </script>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-lg-12">
                <div class="card-box">
                    <canvas id="barChartsecond" width="400" height="75"></canvas>
                    <script>
                        //bar
                        function getvendorbarchartsecond(labelsecond, datasecond) {
                            var ctxB = document.getElementById("barChartsecond").getContext('2d');
                            var myBarChart = new Chart(ctxB, {
                                type: 'bar',
                                data: {
                                    labels: labelsecond,
                                    datasets: [{
                                        label: 'Vendor wise Employee Count',
                                        data: datasecond,
                                        backgroundColor: [
                                          'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                         'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                           'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                           'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                           'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                           'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                        ],
                                        borderColor: [
                                          'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                         'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                           'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                           'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                           'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                           'rgba(255,99,132,1)',
                                          'rgba(54, 162, 235, 1)',
                                          'rgba(255, 206, 86, 1)',
                                          'rgba(75, 192, 192, 1)',
                                          'rgba(153, 102, 255, 1)',
                                          'rgba(255, 159, 64, 1)',
                                        ],
                                        borderWidth: 1
                                    }]
                                },
                                options: {
                                    scales: {
                                        yAxes: [{
                                            ticks: {
                                                fontSize: 12,
                                            },
                                            gridLines: {
                                                color: "rgba(0, 0, 0, 0)",
                                            }
                                        }],
                                        xAxes: [{
                                            ticks: {
                                                fontSize: 9,
                                                fontStyle: 'bold',
                                            }, gridLines: {
                                                color: "rgba(0, 0, 0, 0)",
                                            }
                                        }]
                                    }
                                }
                            });
                        }

                    </script>
                </div>
            </div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <div class="card card-table">
                    <div class="card-body">
                        <canvas id="lineChart" width="400" height="150"></canvas>
                        <script>
                            function agingwise(labelaging, ageingdata) {
                                var canvas = document.getElementById("lineChart");
                                var ctx = canvas.getContext('2d');
                                // Global Options:
                                Chart.defaults.global.defaultFontColor = 'black';
                                Chart.defaults.global.defaultFontSize = 9;

                                var data = {
                                    labels: labelaging,
                                    datasets: [{
                                        label: "Aging Wise Employee Count",
                                        fill: false,
                                        lineTension: 0.1,
                                        backgroundColor: "rgba(225,0,0,0.4)",
                                        borderColor: "#fd7e14", // The main line color
                                        borderCapStyle: 'square',
                                        borderDash: [], // try [5, 15] for instance
                                        borderDashOffset: 0.0,
                                        borderJoinStyle: 'miter',
                                        pointBorderColor: "black",
                                        pointBackgroundColor: "white",
                                        pointBorderWidth: 1,
                                        pointHoverRadius: 8,
                                        pointHoverBackgroundColor: "yellow",
                                        pointHoverBorderColor: "brown",
                                        pointHoverBorderWidth: 2,
                                        pointRadius: 4,
                                        pointHitRadius: 10,
                                        // notice the gap in the data and the spanGaps: true
                                        data: ageingdata,
                                        spanGaps: true,
                                    }
                                    ]
                                };

                                // Notice the scaleLabel at the same level as Ticks
                                var options = {
                                    scales: {
                                        yAxes: [{
                                            ticks: {
                                                beginAtZero: true,
                                            },
                                            gridLines: {
                                                color: "rgba(0, 0, 0, 0)",
                                            },
                                            scaleLabel: {
                                                display: true,
                                                labelString: '',
                                                fontSize: 9
                                            }
                                        }],
                                        xAxes: [{
                                            ticks: {
                                                fontSize: 9,
                                                fontStyle: 'bold',
                                            }, gridLines: {
                                                color: "rgba(0, 0, 0, 0)",
                                            }
                                        }]
                                    }
                                };

                                // Chart declaration:
                                var myBarChart = new Chart(ctx, {
                                    type: 'line',
                                    data: data,
                                    options: options
                                });
                            }
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script>
        $(document).ready(function () {
            getvendor();
            getageing();
            divionwisevendor();
        });
        var label = [];
        var cnt = [];
        var labelsecond = [];
        var cntsecond = [];
        var labelageing = [];
        var cntageing = [];
        var division = [];
        function getvendor() {
            loadmyloading();
            $.ajax({

                url: 'Dashboard.aspx/getvendormethod',

                type: "POST",

                dataType: "json",

                data: JSON.stringify({ typ: "1" }),//vendor count

                contentType: "application/json; charset=utf-8",

                success: function (data) {
                    if (data.d.length > 0) {
                        dataD = JSON.parse(data.d);
                        var datalength = dataD.length;
                        for (var i = 0; i < dataD.length - 31; i++) {
                            label.push(dataD[i].PROJECT_NM);
                            cnt.push(dataD[i].CNT);
                        }
                        for (var j = 31; j < dataD.length; j++) {
                            labelsecond.push(dataD[j].PROJECT_NM);
                            cntsecond.push(dataD[j].CNT);
                        }
                        getvendorbarchart(label, cnt);
                        getvendorbarchartsecond(labelsecond, cntsecond);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
            removemyloading();
        }


        function getageing() {
            loadmyloading();
            $.ajax({

                url: 'Dashboard.aspx/getageing',

                type: "POST",

                dataType: "json",

                data: JSON.stringify({ typ: "4" }),//ageing details

                contentType: "application/json; charset=utf-8",

                success: function (data) {
                    if (data.d.length > 0) {
                        dataD = JSON.parse(data.d);
                        var datalength = dataD.length;
                        for (var i = 0; i < dataD.length ; i++) {
                            labelageing.push(dataD[i].AGE);
                            cntageing.push(dataD[i].CNT);
                        }
                        agingwise(labelageing, cntageing);
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
            removemyloading();
        }

        function divionwisevendor() {
            loadmyloading();
            $.ajax({

                url: 'Dashboard.aspx/divionwisevendordata',

                type: "POST",

                dataType: "json",

                data: JSON.stringify({ typ: "1A" }),//ageing details

                contentType: "application/json; charset=utf-8",

                success: function (data) {
                    if (data.d.length > 0) {
                        //chart code
                        var numberWithCommas = function (x) {
                            return x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
                        };
                        var dates = data.d[0].Div_code.split(",");
                        console.log("dates", dates);
                        var labelDt = [];
                        var dataset1 = data.d;

                        console.log("dataset1", dataset1)
                        var bar_ctx = document.getElementById('bar-chart');



                        Chart.Tooltip.positioners.custom = function (elements, position) {
                            if (!elements.length) {
                                return false;
                            }
                            var offset = 0;
                            //adjust the offset left or right depending on the event position
                            if (elements[0]._chart.width / 2 > position.x) {
                                offset = 10;
                            } else {
                                offset = -20;
                            }
                            return {
                                x: position.x + offset,
                                y: position.y
                            }
                        }
                        var bar_chart = new Chart(bar_ctx, {
                            type: 'bar',
                            data: {
                                labels: dates,
                                datasets: dataset1,
                            },
                            options: {
                                //animation: {
                                //    duration: 10,
                                //},
                                tooltips: {
                                    mode: 'label',
                                    callbacks: {
                                        label: function (tooltipItem, data) {
                                            return data.datasets[tooltipItem.datasetIndex].label + ": " + numberWithCommas(tooltipItem.yLabel);
                                        }
                                    },
                                    position: 'custom',
                                },
                                scales: {
                                    xAxes: [{
                                        stacked: true,
                                        gridLines: { display: false },
                                    }],
                                    yAxes: [{
                                        stacked: true,
                                        ticks: {
                                            callback: function (value) { return numberWithCommas(value); },
                                        },
                                        gridLines: { display: false },
                                    }],
                                },
                                legend: { display: false }
                            },
                            plugins: [{
                                beforeInit: function (chart) {
                                    chart.data.labels.forEach(function (value, index, array) {
                                        var a = [];
                                        a.push(value.slice(0, 5));
                                        var i = 1;
                                        while (value.length > (i * 5)) {
                                            a.push(value.slice(i * 5, (i + 1) * 5));
                                            i++;
                                        }
                                        array[index] = a;
                                    })
                                }
                            }]
                        }
                        );
                        //chart code
                        removemyloading();
                    }
                },
                error: function (err) {
                    console.log(err);
                }
            });
        }
    </script>
</asp:Content>

