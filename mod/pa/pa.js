function disable_fields(){
     $(":checkbox").click(function(){

    if ($("#pa_not_plan").is(':checked')) {
            $("#pa_place").prop('disabled', true);
            $("#pa_date").prop('disabled', true);
        }
        else{
            $("#pa_place").prop('disabled', false);
            $("#pa_date").prop('disabled', false);
        }
    if ($("#drill_not_plan").is(':checked')) {
            $("#drill_date").prop('disabled', true);
        }
        else{
            $("#drill_date").prop('disabled', false);
        }
 });

}

//google charts for hazard history
function hazard_chart(){

     google.load("visualization", "1", {packages:["corechart"]});
      
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Asses Date', 'Tsunami', 'Cyclones','Floods','Droughts','Landslides'],
          ['2004', 4,5,6,8,9],
          ['2005', 1,6,8,3,2]
        ]);
        //sszgoogle.setOnLoadCallback(drawChart);

        var options = {
          title: 'Hazard Assesment',
          curveType: 'function',
          legend: { position: 'bottom' },
          vAxis: { ticks: [0,10,20,30,40,50,60,70,80,90,100,110,120,130] }
        };

         var chart = new google.visualization.LineChart(document.getElementById("chart_div"));

        chart.draw(data, options);
      }
}

function tempCheckBox(){
    $("select").change(function(){

        if ($("#pA").val()=="1") {
            $('#pA_field').slideDown();
  
        } if ($("#pA").val()=="2"){
            $('#pA_field').slideUp();

        }
        if ($("#eW").val()=="1"){
            $('#eW_field').slideDown();
   
        }
        if ($("#eW").val()=="2"){
            $('#eW_field').slideUp();
    
        }
        if ($("#sA").val()=="1"){
            $('#sA_field').slideDown();
  
        }
        if ($("#sA").val()=="2"){
            $('#sA_field').slideUp();
    
        }
        if ($("#drill").val()=="1"){
            $('#drill_field').slideDown();
      
        }
        if ($("#drill").val()=="2"){
            $('#drill_field').slideUp();
         
        }
        if ($("#plan").val()=="1"){
            $('#plan_field').slideDown();

        }
        if ($("#plan").val()=="2"){
            $('#plan_field').slideUp();
 
        }

    });
}

function cal(){
    $('select').change(function(){t_score()});
}

function t_score(){
    var f_1 = document.getElementById("flood_poten").value;
    var f_2 = document.getElementById("flood_frq").value;
    var f_3 = document.getElementById("flood_SP").value;
    document.getElementById("t_flood").innerHTML = parseInt(f_1)*parseInt(f_2)*parseInt(f_3);

    var l_1 = document.getElementById("landslide_poten").value;
    var l_2 = document.getElementById("landslide_frq").value;
    var l_3 = document.getElementById("landslide_SP").value;
    document.getElementById("t_landslide").innerHTML = parseInt(l_1)*parseInt(l_2)*parseInt(l_3);

    var d_1 = document.getElementById("drought_poten").value;
    var d_2 = document.getElementById("drought_frq").value;
    var d_3 = document.getElementById("drought_SP").value;
    document.getElementById("t_drought").innerHTML = parseInt(d_1)*parseInt(d_2)*parseInt(d_3);

    var c_1 = document.getElementById("cyclones_poten").value;
    var c_2 = document.getElementById("cyclones_frq").value;
    var c_3 = document.getElementById("cyclones_SP").value;
    document.getElementById("t_cyclones").innerHTML = parseInt(c_1)*parseInt(c_2)*parseInt(c_3);

    var t_1 = document.getElementById("tsunami_poten").value;
    var t_2 = document.getElementById("tsunami_frq").value;
    var t_3 = document.getElementById("tsunami_SP").value;
    document.getElementById("t_tsunami").innerHTML = parseInt(t_1)*parseInt(t_2)*parseInt(t_3);

}


function get_hazard() {
    var r = new Object();
    r.today             = getToday();
    r.hazard_user       ="user";
    r.flood_poten       =$("#flood_poten").val();
    r.flood_frq         =$("#flood_frq").val();
    r.flood_SP          =$("#flood_SP").val();
    r.landslide_poten   =$("#landslide_poten").val();
    r.landslide_frq     =$("#landslide_frq").val();
    r.landslide_SP      =$("#landslide_SP").val();
    r.drought_poten     =$("#drought_poten").val();
    r.drought_frq       =$("#drought_frq").val();
    r.drought_SP        =$("#drought_SP").val();
    r.cyclones_poten    =$("#cyclones_poten").val();
    r.cyclones_frq      =$("#cyclones_frq").val();
    r.cyclones_SP       =$("#cyclones_SP").val();
    r.tsunami_poten     =$("#tsunami_poten").val();
    r.tsunami_frq       =$("#tsunami_frq").val();
    r.tsunami_SP        =$("#tsunami_SP").val();

    var rj = JSON.stringify(r);
    return(rj);

}


function get_capacity() {
    var r = new Object();
    r.today             = getToday();
    r.capacity_user     ="user";
    r.update_dis_data   =$("#update_dis_data").val();
    r.pA                =$("#pA").val();
    r.pa_date           =$("#pa_date").val();
    r.pa_place          =$("#pa_place").val();
    r.eW                =$("#eW").val();
    r.eW2               =$("#eW2").val();
    r.sA                =$("#sA").val();
    r.sA2               =$("#sA2").val();
    r.sA3               =$("#sA3").val();
    r.emp               =$("#emp").val();
    r.emp2              =$("#emp2").val();
    r.eRM               =$("#eRM").val();
    r.drill             =$("#drill").val();
    r.drill_date        =$("#drill_date").val();
    r.plan              =$("#plan").val();
    r.plan2             =$("#plan2").val();

    var rj = JSON.stringify(r);
    return(rj);

}


function getToday()
{
    var today = new Date();
    var dd = today.getDate();
    var mm = today.getMonth()+1; //January is 0!
    var yyyy = today.getFullYear();

    if(dd<10) {
        dd='0'+dd
    } 

    if(mm<10) {
        mm='0'+mm
    } 

    today = yyyy+'-'+mm+'-'+dd;
    return (today);
}

function showAlert(){
    alert("alert");
}

function showCapacityHistory(data){
    

    $('#history_cap').empty();
    for (var i = 0; i < data.length; i++){
        var score = data[i]['update_dis_data']*1.0 + data[i]['pA']*data[i]['pa_date']*data[i]['pa_place']*1.0 +
        data[i]['eW']*1.0*data[i]['eW2'] +
        data[i]['sA']*1.0*data[i]['sA2']*data[i]['sA3'] + 0+data[i]['emp']*1.0*data[i]['emp2']+data[i]['eRM']*1.0+
        data[i]['drill']*1.0+data[i]['plan']*1.0*data[i]['plan2'];

        $('#history_cap').append('</br><p>Capacity Assesment on '+data[i]['capacity_date']+'\
            <a onclick="get_cap_report('+score+','+data[i]['date']+')"> Report</a></p></br>');
    }
}

function showHistory(data){
    if($('#haz_title').length){
        $('#history').empty();
        $('#hazard_history').html('History');
    }    
    else{
        $('#hazard_history').html('Hide');
    for (var i = 0; i < data.length; i++){
        $('#history').prepend('<div class="his" style="display: none" id="'+data[i]['hazard_id']+'" ><table border="1">\
                    <tr>\
                        <td> HAZARD </td>\
                        <td> POTENTIAL DAMAGE </td>\
                        <td> FREQUENCY </td>\
                        <td> SECONDARY PROBLEMS </td>\
                        <td> TOTAL SCORE </td>\
                    </tr>\
                    <tr>\
                        <td> Flood </td>\
                        <td>\
                            '+data[i]['flood_poten']+'\
                        </td>\
                        <td>\
                            '+data[i]['flood_frq']+'\
                        </td>\
                        <td>\
                            '+data[i]['flood_SP']+'\
                        </td>\
                            <td>'+parseInt(data[i]['flood_poten'])*parseInt(data[i]['flood_frq'])*parseInt(data[i]['flood_SP'])+'</td>\
                    </tr>\
                    <tr>\
                        <td> Landslide </td>\
                        <td>\
                            '+data[i]['landslide_poten']+'\
                        </td>\
                        <td>\
                            '+data[i]['landslide_frq']+'\
                        </td>\
                        <td>\
                            '+data[i]['landslide_SP']+'\
                        </td>\
                            <td>'+parseInt(data[i]['landslide_poten'])*parseInt(data[i]['landslide_frq'])*parseInt(data[i]['landslide_SP'])+'</td>\
                    </tr>\
                    <tr>\
                        <td> Drought </td>\
                        <td>\
                            '+data[i]['drought_poten']+'\
                        </td>\
                        <td>\
                            '+data[i]['drought_frq']+'\
                        </td>\
                        <td>\
                            '+data[i]['drought_SP']+'\
                        </td>\
                            <td>'+parseInt(data[i]['drought_poten'])*parseInt(data[i]['drought_frq'])*parseInt(data[i]['drought_SP'])+'</td>\
                    </tr>\
                    <tr>\
                        <td> Cyclones </td>\
                        <td>\
                            '+data[i]['cyclones_poten']+'\
                        </td>\
                        <td>\
                            '+data[i]['cyclones_frq']+'\
                        </td>\
                        <td>\
                            '+data[i]['cyclones_SP']+'\
                        </td>\
                            <td>'+parseInt(data[i]['cyclones_poten'])*parseInt(data[i]['cyclones_frq'])*parseInt(data[i]['cyclones_SP'])+'</td>\
                    </tr>\
                    <tr>\
                        <td> Tsunami </td>\
                        <td>\
                            '+data[i]['tsunami_poten']+'\
                        </td>\
                        <td>\
                            '+data[i]['tsunami_frq']+'\
                        </td>\
                        <td>\
                            '+data[i]['tsunami_SP']+'\
                        </td>\
                            <td>'+parseInt(data[i]['tsunami_poten'])*parseInt(data[i]['tsunami_frq'])*parseInt(data[i]['tsunami_SP'])+'</td>\
                    </tr>\
                    </table></div><br></br>');
        var tsunami = parseInt(data[i]['tsunami_poten'])*parseInt(data[i]['tsunami_frq'])*parseInt(data[i]['tsunami_SP']); 
        var cyclones = parseInt(data[i]['cyclones_poten'])*parseInt(data[i]['cyclones_frq'])*parseInt(data[i]['cyclones_SP']);
        var drought = parseInt(data[i]['drought_poten'])*parseInt(data[i]['drought_frq'])*parseInt(data[i]['drought_SP']);
        var landslides = parseInt(data[i]['landslide_poten'])*parseInt(data[i]['landslide_frq'])*parseInt(data[i]['landslide_SP']);
        var flood = parseInt(data[i]['flood_poten'])*parseInt(data[i]['flood_frq'])*parseInt(data[i]['flood_SP']);
        
        $('#history').prepend("<p><b>Hazard Assesment on :</b>"+data[i]['hazard_date']+"<a onclick='get_hazard_report("+flood+","+cyclones+","+landslides+","+drought+","+tsunami+","+data[i]['hazard_date']+")'> Report</a> by "+data[i]['hazard_user']+"</p>");
        
   }     
     
      $('#history').prepend("<h3><div id='haz_title'><b>Hazard history</b></div></h3>");
  }

}




function show_his(data){
    $('#'+data).toggle();
}


function show_risk_history(data)
{
     $('#history_risk').empty();
    for (var i = 0; i < data.length; i++){
        $('#history_risk').append('</br><p>Risk Assesment on '+data[i]['date']+'\
            <a onclick="get_risk_report('+data[i]['score_e']+','+data[i]['score_s']+',\
            '+data[i]['score_cc']+','+data[i]['score_ac']+','+data[i]['date']+')"> Report</a></p></br>');
    }
}


function susceptibility(){

    var sa=$("input[name=sa]").val();
    sa=sa*0.5;

    var sb=$("input[name=sb]").val();
    sb=sb*0.5;

    var sc=$("input[name=sc]").val();
    sc=sc*0.125;

    var sd=$("input[name=sd]").val();
    sd=sd*0.5;

    var se=$("input[name=se]").val();
    se=se*0.5;

    var poverty=sd+se;
    poverty=poverty*0.33;

    var sf=$("input[name=sf]").val();
    sf=sf*0.33;

    var sg=$("input[name=sg]").val();
    sg=sg*0.33;

    var sh=$("input[name=sh]").val();
    sh=sh*0.5;

    var si=$("input[name=si]").val();
    si=si*0.5;



    var pub_inf=sa+sb;
    var housing_conditiond=sc;
    var pov_and_dep=sf+sg+poverty ;
    var econ_cap= sh+si;

    var sus= 0.25*(econ_cap + pub_inf) + 0.125*housing_conditiond + 0.375*pov_and_dep;
    return sus;

}

function exposure(){
    var ea=$("input[name=ea]").val();
    ea=ea*0.2;

    var eb=$("input[name=eb]").val();
    eb=eb*0.2;

    var ec=$("input[name=ec]").val();
    ec=ec*0.2;

    var ed=$("input[name=ed]").val();
    ed=ed*0.2;

    var ee=$("input[name=ee]").val();
    ee=ee*0.2;

    var exposure= ea+ eb+ ec+ ed+ ee;
    return exposure;

}

function coping_capacity(){
    var cca=$("input[name=cca]").val();
    cca=cca*0.5;

    var ccb=$("input[name=ccb]").val();
    ccb=ccb*0.5;
;
    var gov = cca+ccb;

    var ccc=$("input[name=ccc]").val();
    ccc=ccc*0.8;

    var ccd=$("input[name=ccd]").val();
    ccd=ccd*0.2;

    var soc = ccc+ccd;

    var cce1=$("input[name=cce1]").val();
    cce1=cce1*0.75;

    var cce2=$("input[name=cce2]").val();
    cce2=cce2*0.25;

    var cce= cce1+cce2;
    cce= cce*0.33;

    var ccf=$("input[name=ccf]").val();
    ccf=ccf*0.33;

    var ccg=$("input[name=ccg]").val();
    ccg=ccg*0.33;

    var econ = 0.33* (cce+ ccf+ ccg);

    var coping_cap= 0.33*gov + 1.667*soc + 0.5*econ;
    return coping_cap;

}

function adaptive_capacity(){
    var aca=$("input[name=aca]").val();
    aca=aca*0.5;

    var acb=$("input[name=acb]").val();
    acb=acb*0.5;

    var edu=aca+acb;

    var acc=$("input[name=acc]").val();

    var acd=$("input[name=acd]").val();

    var ace=$("input[name=ace]").val();

    var adaptive_cap= 0.4*edu + 0.2* ( acc+ acd+ ace);
    return adaptive_cap;

}


function LRI(){
     var l = new Object();
    l.sus = susceptibility();
    l.exp =exposure();
    l.cc=coping_capacity();
    l.ac=adaptive_capacity();

    l.user="user";
    l.today = getToday();

    var lj = JSON.stringify(l);
    return(lj);

}

function get_hazard_report(flood,cyclones,landslides,drought,tsunami,date)
{
    var pdf = new jsPDF('p', 'pt', 'a4');

         

        var source = '<html><head>\
 <div>\
     <div id="header">\
    <img src="res/img/Emblem_of_Sri_Lanka.svg.png" width="50px" style="position: relative;left: 300px;">\
    <h3>Ministry of Health</h3><h1>Disaster Management Information System</h1>\
    <p>Disaster Preparedness and Response Division <br>Ministry of Health, Sri Lanka</p></div>\
 <div style="top: 310px; left: 50;"><table>\
        <tr><td><h3>Preparedness Assesment : <small>Hazard</small></h3></td></tr>\
        <ul>\
        <tr><td><li><h4>Date : '+date+'</h4></li></td></tr>\
         <tr><td><li><h4>Assessor Name : Administrator</h4></li></td></tr>\
        </ul>\
        <tr><td><h4>Flood : '+flood+'</h4></td></tr>\
        <tr><td><h4>Landslide : '+landslides+'</h4></td></tr>\
        <tr><td><h4>Drought : '+drought+'</h4></td></tr>\
        <tr><td><h4>Cyclones : '+cyclones+'</h4></td></tr>\
        <tr><td><h4>Tsunami : '+tsunami+'</h4></td></tr></table></div></div></body></html>';

        //var pdf = new jsPDF('p', 'pt', 'letter');

// source can be HTML-formatted string, or a reference
// to an actual DOM element from which the text will be scraped.


// we support special element handlers. Register them with jQuery-style
// ID selector for either ID or node name. ("#iAmID", "div", "span" etc.)
// There is no support for any other type of selectors
// (class, of compound) at this time.
specialElementHandlers = {
    // element with id of "bypass" - jQuery style selector
    '#bypassme': function(element, renderer){
        // true = "handled elsewhere, bypass text extraction"
        return true;
    }
}

margins = {
    top: 80,
    bottom: 60,
    left: 40,
    width: 522
  };
  // all coords and widths are in jsPDF instance's declared units
  // 'inches' in this case
pdf.fromHTML(
    source // HTML string or DOM elem ref.
    , margins.left // x coord
    , margins.top // y coord
    , {
        'width': margins.width // max width of content on PDF
        , 'elementHandlers': specialElementHandlers
    },
    function (dispose) {
      // dispose: object with X, Y of the last line add to the PDF
      //          this allow the insertion of new lines after html
        pdf.output('dataurlnewwindow'); 
      },
    margins
  );
}



function get_risk_report(exp,sus,cc,ac,date)
{
    var pdf = new jsPDF('p', 'pt', 'a4');

         var vi = sus+cc+ac;
         var lri = exp*vi;

        var source = '<html><head>\
 <div>\
     <div id="header">\
    <img src="res/img/Emblem_of_Sri_Lanka.svg.png" width="50px" style="position: relative;left: 300px;">\
    <h3>Ministry of Health</h3><h1>Disaster Management Information System</h1>\
    <p>Disaster Preparedness and Response Division <br>Ministry of Health, Sri Lanka</p></div>\
 <div style="top: 310px; left: 50;"><table>\
        <tr><td><h3>Risk Assesment</h3></td></tr>\
        <ul>\
        <tr><td><li><h4>Date : '+date+'</h4></li></td></tr>\
         <tr><td><li><h4>Assessor Name : Administrator</h4></li></td></tr>\
        </ul>\
        <tr><td><h4>Exposure : '+exp+'</h4></td></tr>\
        <tr><td><h4>Vulnerability Index : '+vi+'</h4></td></tr>\
        <tr><td><h4>Local Risk Index : '+lri+'</h4></td></tr></table></div></div></body></html>';

        //var pdf = new jsPDF('p', 'pt', 'letter');

// source can be HTML-formatted string, or a reference
// to an actual DOM element from which the text will be scraped.


// we support special element handlers. Register them with jQuery-style
// ID selector for either ID or node name. ("#iAmID", "div", "span" etc.)
// There is no support for any other type of selectors
// (class, of compound) at this time.
specialElementHandlers = {
    // element with id of "bypass" - jQuery style selector
    '#bypassme': function(element, renderer){
        // true = "handled elsewhere, bypass text extraction"
        return true;
    }
}

margins = {
    top: 80,
    bottom: 60,
    left: 40,
    width: 522
  };
  // all coords and widths are in jsPDF instance's declared units
  // 'inches' in this case
pdf.fromHTML(
    source // HTML string or DOM elem ref.
    , margins.left // x coord
    , margins.top // y coord
    , {
        'width': margins.width // max width of content on PDF
        , 'elementHandlers': specialElementHandlers
    },
    function (dispose) {
      // dispose: object with X, Y of the last line add to the PDF
      //          this allow the insertion of new lines after html
        pdf.output('dataurlnewwindow'); 
      },
    margins
  );
}

function get_cap_report(score,date)
{
    if(score<12) 
        {
            var status = 'Satisfactory';
        }
    else if(score >12 && score < 20)
        { 
            var status = 'Moderate level of planning and execution but need to improve on certain areas';
        } 
    else if(score> 20)
        {
            var status  =  'Unsatisfactory';
        }

    var pdf = new jsPDF('p', 'pt', 'a4');

         

        var source = '<html><head>\
 <div>\
     <div id="header">\
    <img src="res/img/Emblem_of_Sri_Lanka.svg.png" width="50px" style="position: relative;left: 300px;">\
    <h3>Ministry of Health</h3><h1>Disaster Management Information System</h1>\
    <p>Disaster Preparedness and Response Division <br>Ministry of Health, Sri Lanka</p></div>\
 <div style="top: 310px; left: 50;"><table>\
        <tr><td><h3>Capacity Assesment</h3></td></tr>\
        <ul>\
        <tr><td><li><h4>Date : '+date+'</h4></li></td></tr>\
         <tr><td><li><h4>Assessor Name : Administrator</h4></li></td></tr>\
        </ul>\
        <tr><td><h4>Full Score : '+score+'</h4></td></tr>\
        <tr><td><h4>Statement : '+status+'</h4></td></tr></table></div></div></body></html>';

        //var pdf = new jsPDF('p', 'pt', 'letter');

// source can be HTML-formatted string, or a reference
// to an actual DOM element from which the text will be scraped.


// we support special element handlers. Register them with jQuery-style
// ID selector for either ID or node name. ("#iAmID", "div", "span" etc.)
// There is no support for any other type of selectors
// (class, of compound) at this time.
specialElementHandlers = {
    // element with id of "bypass" - jQuery style selector
    '#bypassme': function(element, renderer){
        // true = "handled elsewhere, bypass text extraction"
        return true;
    }
}

margins = {
    top: 80,
    bottom: 60,
    left: 40,
    width: 522
  };
  // all coords and widths are in jsPDF instance's declared units
  // 'inches' in this case
pdf.fromHTML(
    source // HTML string or DOM elem ref.
    , margins.left // x coord
    , margins.top // y coord
    , {
        'width': margins.width // max width of content on PDF
        , 'elementHandlers': specialElementHandlers
    },
    function (dispose) {
      // dispose: object with X, Y of the last line add to the PDF
      //          this allow the insertion of new lines after html
        pdf.output('dataurlnewwindow'); 
      },
    margins
  );
}

