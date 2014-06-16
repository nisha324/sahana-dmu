
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" lang="en" xml:lang="en">
<head>
<title>DMU Sahana</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta name="Software " content="Sahana for the Disaster Management Unit, Ministry of Health, Sri Lanka" />
<meta name="Website" content="http://pl.nlm.nih.gov" />
<meta name="Licence" content="Lesser General Public Licence, Version 2.1" />
<meta name="Licence Website" content="http://www.gnu.org/licenses/lgpl-2.1.txt" />
<meta name="google-site-verification" content="Y2Ts00HnBQEr3M3KegrKRRAMVuQPejmqeqPKDsMGRGw" />
<link rel="chrome-webstore-item" href="https://chrome.google.com/webstore/detail/fbnpmpdcnjkhfcgeeklebjmopaheplce">
<link rel="stylesheet" media="screen, projection" type="text/css" href="theme/lpf3/sahana.css" />
<link rel="stylesheet" media="print" type="text/css" href="theme/lpf3/print.css" />
<link rel="stylesheet" media="handheld" type="text/css" href="theme/lpf3/mobile.css" />
<!--[if IE 6]>
<link rel="stylesheet" type="text/css" href="theme/lpf3/ie6.css" />
<![endif]-->
<!--[if IE 7]>
<link rel="stylesheet" type="text/css" href="theme/lpf3/ie7.css" />
<![endif]-->
<!--[if IE 8]>
<link rel="stylesheet" type="text/css" href="theme/lpf3/ie8.css" />
<![endif]-->
<!--[if IE 9]>
<link rel="stylesheet" type="text/css" href="theme/lpf3/ie9.css" />
<![endif]-->

<link rel="icon" type="image/png" href="favicon.png">


<script type="text/javascript" src="res/js/vesuvius.js"></script>
<script type="text/javascript" src="index.php?stream=text&amp;mod=xst&amp;act=help"></script>

</head>
<body>

<script type="text/javascript">
function todo(){
	calcVals();
	calcVals1();
	calcVals2();
	calcVals3();
	calcVals4();
	}

function calcVals() {
var score1=document.getElementById("movies1").value
var score2=document.getElementById("movies2").value
var score3=document.getElementById("movies3").value
var pick1=document.getElementById("movies1").options[document.getElementById("movies1").selectedIndex].text
var pick2=document.getElementById("movies2").options[document.getElementById("movies2").selectedIndex].text
var pick3=document.getElementById("movies3").options[document.getElementById("movies3").selectedIndex].text
var grandscore=score1*score2*score3;
if (grandscore==0){
document.getElementById("results");
} else {
	document.getElementById("results").innerHTML=grandscore
	}
}


function calcVals1() {
var score4=document.getElementById("movies4").value
var score5=document.getElementById("movies5").value
var score6=document.getElementById("movies6").value
var pick4=document.getElementById("movies4").options[document.getElementById("movies4").selectedIndex].text
var pick5=document.getElementById("movies5").options[document.getElementById("movies5").selectedIndex].text
var pick6=document.getElementById("movies6").options[document.getElementById("movies6").selectedIndex].text
var grandscore=score4*score5*score6;
if (grandscore==0){
document.getElementById("results1");
} else {
	document.getElementById("results1").innerHTML=grandscore
	}
}



function calcVals2() {
var score7=document.getElementById("movies7").value
var score8=document.getElementById("movies8").value
var score9=document.getElementById("movies9").value
var pick7=document.getElementById("movies7").options[document.getElementById("movies7").selectedIndex].text
var pick8=document.getElementById("movies8").options[document.getElementById("movies8").selectedIndex].text
var pick9=document.getElementById("movies9").options[document.getElementById("movies9").selectedIndex].text
var grandscore=score7*score8*score9;
if (grandscore==0){
document.getElementById("results2");
} else {
	document.getElementById("results2").innerHTML=grandscore
	}
}




function calcVals3() {
var score10=document.getElementById("movies10").value
var score11=document.getElementById("movies11").value
var score12=document.getElementById("movies12").value
var pick10=document.getElementById("movies10").options[document.getElementById("movies10").selectedIndex].text
var pick11=document.getElementById("movies11").options[document.getElementById("movies11").selectedIndex].text
var pick12=document.getElementById("movies12").options[document.getElementById("movies12").selectedIndex].text
var grandscore=score10*score11*score12;
if (grandscore==0){
document.getElementById("results3");
} else {
	document.getElementById("results3").innerHTML=grandscore
	}
}







function calcVals4() {
var score13=document.getElementById("movies13").value
var score14=document.getElementById("movies14").value
var score15=document.getElementById("movies15").value
var pick13=document.getElementById("movies13").options[document.getElementById("movies13").selectedIndex].text
var pick14=document.getElementById("movies14").options[document.getElementById("movies14").selectedIndex].text
var pick15=document.getElementById("movies15").options[document.getElementById("movies15").selectedIndex].text
var grandscore=score13*score14*score15;
if (grandscore==0){
document.getElementById("results4");
} else {
	document.getElementById("results4").innerHTML=grandscore
	}
}


</script>






<div id="container"><div id="header" class="clearfix"><div id="leftHeaderLogo"><a href="http://localhost/public_html/sahana-dmu/www/"><img id="leftHeaderLogoImg" src="theme/lpf3/img/moh.jpg" alt="Ministry of Health log"></a></div><div id="rightHeaderLogo"><a href="http://www.launchpad.net/vesuvius"><img src="theme/lpf3/img/vesuvius.png" alt="Sahana Vesuvius Logo"></a></div></div>
			<div id="headerText">
				<h1>DMU Vesuvius for the Test Exercise</h1>
				<h3>of January 1, 2000</h3>
				<h4>Disaster Management Unit</h4>
				<h4>Ministry of Health, Sri Lanka</h4>
			</div>
		<div id="wrapper" class="clearfix"><div id="wrapper_menu">
		<div id="menuwrap">
		<ul id="menu">
	<li ><a href="arrivals">Arrivals</a></li><li ><a href="search">Search for a Person</a></li><li ><a href="report">Report a Person</a></li><li ><a href="tracking">People I'm Tracking</a></li><li ><a href="resources">Help and Resources</a></li><li ><a href="admin">Administration</a></li><li ><a href="outbound">Outbound Email <span style="color: red;"><b>●</b></span></a></li><li ><a href="inbound">Inbound Email <span style="color: red;"><b>●</b></span></a></li><li ><a href="events">Event Manager</a></li><li ><a href="http://localhost/public_html/sahana-dmu/www/">Home</a></li><li ><a href="http://localhost/public_html/sahana-dmu/www/">Preparedenss</a></li>
		</ul>
		</div> <!-- /menuwrap -->
	
		<div id="loginform">
			<a href="settings">My Settings</a> <span style="color: #e5eaef;">&nbsp;|&nbsp;</span> <a href="logout">Logout</a>
		</div>
	</div><!-- Left hand side menus & login form --><div id="content" class="clearfix">
		<ul id="tabmenu">
	<li id='active' ><a href="pref?session&tabid=0"><span>Hazard Level </span></a></li><li  ><a href="pref?password&tabid=1"><span>Disaster Preparedness Assessment</span></a></li>
		</ul>
	<br><div id="home">
		<div id="rezMain" class="mainArea" style="opacity: 1; width: 300px;">
        <table width="644" height="337" class="emTable" border="1" align="center">
      <tr>
        <td width="112" height="94"><strong>
          <center >
          <h4 title="dd">  HAZARD</h4>
          </center>
        </strong></td>
        <td width="125"><strong>
          <center>
            POTENTIAL DAMAGE
          </center>
        </strong></td>
        <td width="106"><strong>
          <center>
            FREQUENCY
          </center>
        </strong></td>
        <td width="105"><strong>
          <center>
            SECONDARY PROBLEMS
          </center>
        </strong></td>
        <td width="162"><strong>
          <center>
            TOTAL SCORE (multiply all 3)
          </center>
        </strong></td>
      </tr>
      <tr>
        <td><center>
          Flood
        </center></td>
        <td><center>
        <select id="movies1">
        <option selected="0" value="0">Please select</option>
         <option value=1>No damage or surface damage</option>
          <option value=2>Minor damage</option>
          <option value=3>Moderate damage.</option>
          <option value=4>Significant damage.</option>
           <option value=5>Destroyed or nearly destroyed.</option>
        </select>
        </center></td>
        <td><center>
         <select id="movies2">
        <option selected="0" value="0"> Please select</option>
         <option value=1>Has not occurred in last 100 years.</option>
          <option value=2>Happens at least once every fifty years.</option>
          <option value=3>Happens at least once every ten years</option>
           <option value=4>Happens at least once every five years..</option>
           <option value=5>Annual event, or more often</option>
           
        </select>
        </center></td>
        <td><center>
          <select id="movies3">
            <option selected="selected" value="0">Please select</option>
            <option value=1>No secondary effects or problems likely</option>
            <option value=2>At least one secondary effect, short-term in nature.</option>
            <option value=3>Multiple secondary effects.  May last 2 or 3 days</option>
            <option value=4>Significant secondary effect(s).  May last a week.</option>
            <option value=5>Significant secondary effects last more than a week.  </option>
          </select>
      
        </center></td>
        <td><center>
         <div id="results"></div>
        </center></td>
      </tr>
      <tr>
        <td><center>
          Landslide
        </center></td>
        <td><center>
         <select id="movies4">
        <option selected="0" value="0">Please select</option>
         <option value=1>No damage or surface damage</option>
          <option value=2>Minor damage</option>
          <option value=3>Moderate damage.</option>
          <option value=4>Significant damage.</option>
           <option value=5>Destroyed or nearly destroyed.</option>
        </select>
        </center></td>
        <td><center>
         <select id="movies5">
        <option selected="0" value="0">Please select</option>
         <option value=1>Has not occurred in last 100 years.</option>
         
          <option value=2>Happens at least once every fifty years.</option>
          <option value=3>Happens at least once every ten years</option>
           <option value=4>Happens at least once every five years..</option>
           <option value=5>Annual event, or more often</option>
           
        </select>
        </center></td>
        <td><center>
         <select id="movies6">
            <option selected="selected" value="0">Please select</option>
            <option value=1>No secondary effects or problems likely</option>
            <option value=2>At least one secondary effect, short-term in nature.</option>
            <option value=3>Multiple secondary effects.  May last 2 or 3 days</option>
            <option value=4>Significant secondary effect(s).  May last a week.</option>
            <option value=5>Significant secondary effects last more than a week.  </option>
          </select>
        </center></td>
        <td><center>
          <div id="results1"></div>
        </center></td>
      </tr>
      <tr>
        <td><center>
          Drought
        </center></td>
        <td><center>
        <select id="movies7">
        <option selected="0"  value="0">Please select</option>
         <option value=1>No damage or surface damage</option>
          <option value=2>Minor damage</option>
          <option value=3>Moderate damage.</option>
          <option value=4>Significant damage.</option>
           <option value=5>Destroyed or nearly destroyed.</option>
        </select>
        </center></td>
        <td><center>
         <select id="movies8">
        <option selected="0"  value="0">Please select</option>
         <option value=1>Has not occurred in last 100 years.</option>
         
          <option value=2>Happens at least once every fifty years.</option>
          <option value=3>Happens at least once every ten years</option>
           <option value=4>Happens at least once every five years..</option>
           <option value=5>Annual event, or more often</option>
           
        </select>
        </center></td>
        <td><center>
        <select id="movies9">
            <option selected="0" value="0">Please select</option>
            <option value=1>No secondary effects or problems likely</option>
            <option value=2>At least one secondary effect, short-term in nature.</option>
            <option value=3>Multiple secondary effects.  May last 2 or 3 days</option>
            <option value=4>Significant secondary effect(s).  May last a week.</option>
            <option value=5>Significant secondary effects last more than a week.  </option>
          </select>
        </center></td>
        <td><center>
          <div id="results2"></div>
        </center></td>
      </tr>
      <tr>
        <td><center>
          Cyclones
        </center></td>
        <td><center>
        <select id="movies10">
        <option selected="0"  value="0">Please select</option>
         <option value=1>No damage or surface damage</option>
          <option value=2>Minor damage</option>
          <option value=3>Moderate damage.</option>
          <option value=4>Significant damage.</option>
           <option value=5>Destroyed or nearly destroyed.</option>
        </select>
        </center></td>
        <td><center>
       <select id="movies11">
        <option selected="0"  value="0">Please select</option>
         <option value=1>Has not occurred in last 100 years.</option>
         
          <option value=2>Happens at least once every fifty years.</option>
          <option value=3>Happens at least once every ten years</option>
           <option value=4>Happens at least once every five years..</option>
           <option value=5>Annual event, or more often</option>
           
        </select>
        </center></td>
        <td><center>
         <select id="movies12">
            <option selected="selected"  value="0">Please select</option>
            <option value=1>No secondary effects or problems likely</option>
            <option value=2>At least one secondary effect, short-term in nature.</option>
            <option value=3>Multiple secondary effects.  May last 2 or 3 days</option>
            <option value=4>Significant secondary effect(s).  May last a week.</option>
            <option value=5>Significant secondary effects last more than a week.  </option>
          </select>
        </center></td>
        <td><center>
         <div id="results3"></div>
        </center></td>
      </tr>
      <tr>
        <td><center>
          Tsunami
        </center></td>
        <td><center>
        <select id="movies13">
        <option selected="0"  value="0">Please select</option>
         <option value=1>No damage or surface damage</option>
          <option value=2>Minor damage</option>
          <option value=3>Moderate damage.</option>
          <option value=4>Significant damage.</option>
           <option value=5>Destroyed or nearly destroyed.</option>
        </select>
        </center></td>
        <td><center>
         <select id="movies14">
        <option selected="0"  value="0">Please select</option>
         <option value=1>Has not occurred in last 100 years.</option>
         
          <option value=2>Happens at least once every fifty years.</option>
          <option value=3>Happens at least once every ten years</option>
           <option value=4>Happens at least once every five years..</option>
           <option value=5>Annual event, or more often</option>
           
        </select>
        </center></td>
        <td><center>
         <select id="movies15">
            <option selected="selected"  value="0">Please select</option>
            <option value=1>No secondary effects or problems likely</option>
            <option value=2>At least one secondary effect, short-term in nature.</option>
            <option value=3>Multiple secondary effects.  May last 2 or 3 days</option>
            <option value=4>Significant secondary effect(s).  May last a week.</option>
            <option value=5>Significant secondary effects last more than a week.  </option>
          </select>
        </center></td>
        <td><center>
          <div id="results4"></div>
        </center></td>
      </tr>
    </table>
        <span class="mainArea" style="opacity: 1; width: 300px;"><span style="position:absolute; left: 1019px; top: 819px;">
        <input type="button" value="calculate" onclick="todo()" />
        </span></span>
<div style="position:absolute; left: 1008px; top: 833px;"></div>
        
        
        
        
        
        
        </div>
	</div></div><!-- /content --></div><!-- /wrapper --><div id="blueBack">&nbsp;</div>
<div id="footer"><center><table id="footerTable">
		<tr>
		<td>
			<a href="http://www.nlm.nih.gov"><img src="theme/lpf3/img/nlm.png"></a>
			<a href="http://www.nih.gov"><img src="theme/lpf3/img/nih.png"></a>
			<a href="http://www.hhs.gov"><img src="theme/lpf3/img/hhs.png"></a><br>
			Based on the People Locator developed<br>
			by the US National Library of Medicine
		</td>
		<td>
			<a href="http://www.virtusa.com/"><img src="theme/lpf3/img/virtusa_logo.jpg"></a>
		<br>
			A CSR project by Virtusa (Pvt) Ltd <br>
			In corroboration with Virtusa Healthcare policies
			
		</td>
		<td>
			<a href="http://sahanafoundation.org"><img src="theme/lpf3/img/sahana.png"></a><br>
			Powered by<br>
			Sahana Vesuvius
		</td>
		</tr>
	</table>
	<div id="notice"></div>
	</center>
	</div>
</div><!-- /container --></body></html>