// C O D E D   B Y   J O S H U A   S A N G E R
// http://www.jsangerdevelopment.com

// jAlerts.js is used to replace the browser's default alerts. For more information on use, demos, 
// contact info, and more, please visit http://www.jsangerdevelopment.com/jAlerts


/* List of properties

	buttonColor				- 		Changes the main color of the button
	buttonHoverColor		-		Changes the hover color of the button
	buttonText				-		Changes the text value of the button
	buttonTextColor			-		Changes the color of the button's text
	contentColor			-		Changes the color of the main content text
	contentText				-		Changes the text value of the main content
	headingColor			-		Changes the color of the bolded header
	headingText				-		Changes the text value of the bolded header

*/

// Define the variables needed throughout this script
var customAlert = {}
var messageHeight;
var saveOrigin;

// Write the google fonts link to the documents head
$("head").append("<link href='http://fonts.googleapis.com/css?family=PT+Sans:400,700' "		+
	"rel='stylesheet' type='text/css'>");

// Create the message div with header and content section as the first lines of code 
// within the body tag
$("body").prepend("<div class='jAlertsMessage'><h2 class='jAlertsHeading'>This is an "		+
	"important message</h2><p class='jAlertsContent'>Message contents will be "				+
	"placed here. To edit, change the \"contentText\" property when running the "			+
	"function.</p><div class='jAlertsButton'>OK</div></div>");
	
$("body").prepend("<div class='jAlertsOverlay'></div>");

// Set the CSS for the elements that were just added to the document
$(".jAlertsOverlay").css({
	'position'			: 		'fixed'						,
	'zIndex': 999999,// earlier 90 dated 15 may 2020 prasoon
	'top'				: 		0							,
	'left'				: 		0							,
	'right'				: 		0							,
	'bottom'			: 		0							,
	'width'				: 		'100%'						,
	'height'			: 		'100%'						,
	'backgroundColor'	: 		'rgba(0,0,0,0.8)'			,
	'display'			:		'none'				
});

$(".jAlertsMessage").css({

	'padding'			:		'30px 20px'					,
	'width'				:		'420px'						,
	'minWidth'			:		'420px'						,
	'marginLeft'		:		'-210px'					,
	'left'				:		'50%'						,
	'backgroundColor'	: 		'#f9f9f9'					,
	'position'			: 		'fixed'						,
	'top'				: 		'50%'						,
	'zIndex': 999999,// earlier 100 dated 15 may 2020 prasoon
	'color'				: 		'#0a0a0a'					,
	'textAlign'			: 		'center'					,
	'boxShadow'			: 		'0 0 30px rgba(0,0,0,0.7)'	,
	'display'			:		'none'						,
	'fontSize'			:		'16px'						,
	'borderRadius'		:		'3px'
	

});

$(".jAlertsHeading").css({
	'margin'			: 		0							,
	'padding'			: 		0							,
	'letterSpacing'		: 		'1px'						,
	'marginBottom'		: 		'20px'						
});

$(".jAlertsContent").css({
	'margin'			: 		0							,
	'padding'			:		0	
});

$(".jAlertsButton").css({
	'display'			: 		'inline-block'				,
	'padding' 			:		'10px 20px'					,
	'backgroundColor'	: 		'#3498db'					,
	'borderRadius'		: 		'4px'						,	
	'color'				: 		'#f9f9f9'					,
	'marginTop'			: 		'25px'						,
	'cursor'			: 		'pointer'					,
	'fontWeight': '400',		
});   

		

// Main jAlerts.js function. The customAlert is an object which the user edits the properties, 
// and the origin variable is the direction the jAlert will COME IN FROM
function jAlert(customAlert, origin) {
	
	// If the buttonColor is not defined by the user, set a default. Otherwise use what the user entered		
	if (customAlert.buttonColor === undefined) {
		customAlert.buttonColor = "#3498db";
		$(".jAlertsButton").css({'backgroundColor' : customAlert.buttonColor});
	} else {
		$(".jAlertsButton").css({'backgroundColor' : customAlert.buttonColor});
	}
	
	// If the buttonHoverColor is not defined by the user, set a default. Otherwise use what the user entered	
	if (customAlert.buttonHoverColor === undefined) {
		customAlert.buttonHoverColor = "#3078a0";
		$(".jAlertsButton").css({'color' : customAlert.buttonHoverColor});
	} else {
		$(".jAlertsButton").css({'color' : customAlert.buttonHoverColor});
	}
	
	// If the buttonTextColor is not defined by the user, set a default. Otherwise use what the user entered	
	if (customAlert.buttonTextColor === undefined) {
		customAlert.buttonTextColor = "#f9f9f9";
		$(".jAlertsButton").css({'color' : customAlert.buttonTextColor});
	} else {
		$(".jAlertsButton").css({'color' : customAlert.buttonTextColor});
	}
	
	// If the buttonText is not defined by the user, set a default. Otherwise use what the user entered	
	if (customAlert.buttonText === undefined) {
	    debugger;
		customAlert.buttonText = "Okay";
		$(".jAlertsButton").text(customAlert.buttonText);		
	} else {
	    $(".jAlertsButton").text(customAlert.buttonText);	    
	}
	
	// If the headingText is not defined by the user, set a default. Otherwise use what the user entered	
	if (customAlert.headingText === undefined) {
	    //customAlert.headingText = "Alert!";	    
	    customAlert.headingText = "";
		$(".jAlertsHeading").text(customAlert.headingText);
	} else {
		$(".jAlertsHeading").text(customAlert.headingText);
	}
	
	// If the headingColor is not defined by the user, set a default. Otherwise use what the user entered	
	if (customAlert.headingColor === undefined) {
		customAlert.headingColor = "#000000";
		$(".jAlertsHeading").css({'color' : customAlert.headingColor});
	} else {
		$(".jAlertsHeading").css({'color' : customAlert.headingColor});
	}
	
	// If the contentText is not defined by the user, set a default. Otherwise use what the user entered	
	if (customAlert.contentText === undefined) {
		customAlert.contentText = "Message contents will be placed here. To edit, change the \"contentText\" property when running the function.";
		$('.jAlertsContent').text(customAlert.contentText);
	} else {
		$('.jAlertsContent').text(customAlert.contentText);
	}
	
	// If the contentColor is not defined by the user, set a default. Otherwise use what the user entered	
	if (customAlert.contentColor === undefined) {
		customAlert.contentColor = "#000000";
		$('.jAlertsContent').css({'color' : customAlert.contentColor}); 
	} else {
		$('.jAlertsContent').css({'color' : customAlert.contentColor}); 
	}

	// Determine the height of the message and add padding
	messageHeight = $('.jAlertsMessage').height() + 60;

	// Use the height just determined to vertically center the message div
	$(".jAlertsMessage").css({
		'marginTop' : (-messageHeight / 2)
	});
	
	// Switch that controls which direction the jAlert will come in from ...
	switch (origin) {

		// If the user entered "top", animate in from the top to the center and 
		// fade in the background overlay
		case "top" :
			$(".jAlertsMessage").css({
				'top' 			: 		'-100%'				,
				'left' 			:		'50%'				,
				'display'		:		'block'
			});
			$(".jAlertsOverlay").delay(100).fadeIn();
			
			$(".jAlertsMessage").animate({
				'top'			:		'50%'
			});
		break;
		
		// If the user entered "bottom", animate in from the bottom to the center and 
		// fade in the background overlay
		case "bottom" :
			$(".jAlertsMessage").css({
				'top' 			: 		'200%'				,
				'left' 			:		'50%'				,
				'display'		:		'block'
			});
			$(".jAlertsOverlay").delay(100).fadeIn();
			
			$(".jAlertsMessage").animate({
				'top'			:		'50%'
			});
		break;
		
		// If the user entered "left", animate in from the left to the center and 
		// fade in the background overlay
		case "left" :
			$(".jAlertsMessage").css({
				'left' 			: 		'-100%'				,
				'top'			:		'50%'				,
				'display'		:		'block'
			});
			$(".jAlertsOverlay").delay(100).fadeIn();
			
			$(".jAlertsMessage").animate({
				'left'			:		'50%'
			});
			//$('.jAlertsOverlay').click();
			//$("body").find(".jAlertsButton").focus();
			//$('.jAlertsButton').bind("click", jAlertsClose);
			//$("body").on("keypress", function (evt) {
			//    $("body").find(".jAlertsButton").focus();
			//    debugger;
			//    if (evt.keyCode == "13") {
			//        debugger;			       
			//        $('.jAlertsButton').trigger("click");
			//    }
			//});
		break;
		
		// If the user entered "right", animate in from the right to the center and 
		// fade in the background overlay
		case "right" :
			$(".jAlertsMessage").css({
				'left' 			: 		'200%'				,
				'top'			:		'50%'				,
				'display'		:		'block'
			});
			$(".jAlertsOverlay").delay(100).fadeIn();
			
			$(".jAlertsMessage").animate({
				'left'			:		'50%'
			});
		break;
		
		// Otherwise animate the jAlert to come in from the left. 
		default:
		
			origin = "left";
			$(".jAlertsMessage").css({
				'left' 			: 		'-100%'				,
				'display'		:		'block'
			});
			$(".jAlertsOverlay").delay(100).fadeIn();
			
			$(".jAlertsMessage").animate({
				'left'			:		'50%'
			});
		
		break;
		
	} // end switch
	
	// Assign the origin to a temp variable to be used in another function
	saveOrigin = origin;

	// Assign the jAlertsClose() function to the main button 
	//$('.jAlertsButton').bind("click", jAlertsClose);

	//$('.jAlertsButton').click(function () {
	//    window.location.href = window.location.href;
    //});			

	$('.jAlertsButton').click(function () {
	    debugger;
	    if ($('.jAlertsContent').text() == "No Rights Available at this Point,Kindly Conatact to Admin Team" || $('.jAlertsContent').text() == "Session Out!!!" || $('.jAlertsContent').text() == "Basic Information has been updated, Please login again" || $('.jAlertsContent').text() == "Account Information has been updated, Please login again") {
	        window.location.href = "login";
	    } else if ($('.jAlertsContent').text() == "Update Reporting Officer Should be Selected!!!" || $('.jAlertsContent').text() == "Update Reporting Officer Should be Selected!!!Update Reporting Officer Should be Selected!!!" || $('.jAlertsContent').text() == "Error in Sheet,Please Correct and Submit" || $('.jAlertsContent').text() == "Error in Sheet,Please Correct and SubmitError in Sheet,Please Correct and Submit" || $('.jAlertsContent').text() == "Select Atleast one Option" || $('.jAlertsContent').text() == "Select Atleast one OptionSelect Atleast one Option" || $('.jAlertsContent').text() == "Userid/Password RequiredUserid/Password Required" || $('.jAlertsContent').text() == "Userid/Password Required" || $('.jAlertsContent').text() == "Login-id/Password IncorrectLogin-id/Password Incorrect" || $('.jAlertsContent').text() == "Login-id/Password Incorrect" || $('.jAlertsContent').text() == "Effective Date Required!!!" || $('.jAlertsContent').text() == "Effective Date Required!!!Effective Date Required!!!" || $('.jAlertsContent').text() == "Manpower Request can't be process due to Budget Availability" || $('.jAlertsContent').text() == "Manpower Request can't be process due to Budget AvailabilityManpower Request can't be process due to Budget Availability" || $('.jAlertsContent').text() == "All field RequiredAll field Required" || $('.jAlertsContent').text() == "All field Required" || $('.jAlertsContent').text() == "Request Type Reqiured!!!Request Type Reqiured!!!" || $('.jAlertsContent').text() == "Request Type Reqiured!!!" || $('.jAlertsContent').text() == "Indent Document Required!!!Indent Document Required!!!" || $('.jAlertsContent').text() == "Indent Document Required!!!" || $('.jAlertsContent').text() == "Please fill all the mandatory fileds" || $('.jAlertsContent').text() == "Please fill all the mandatory filedsPlease fill all the mandatory fileds" || $('.jAlertsContent').text() == "Manpower Request can't be process due to no Budget AvailabilityManpower Request can't be process due to no Budget Availability" || $('.jAlertsContent').text() == "Manpower Request can't be process due to no Budget Availability" || $('.jAlertsContent').text() == "Please fill all the mandatory fileds" || $('.jAlertsContent').text() == "Please fill all the mandatory filedsPlease fill all the mandatory fileds" || $('.jAlertsContent').text() == "Please Select Budget AvailabilityPlease Select Budget Availability" || $('.jAlertsContent').text() == "Please Select Budget Availability" || $('.jAlertsContent').text() == "Please Select ReviewerPlease Select Reviewer" || $('.jAlertsContent').text() == "Please Select Reviewer" || $('.jAlertsContent').text() == "Please fill the mandatory fileds" || $('.jAlertsContent').text() == "Please fill the mandatory filedsPlease fill the mandatory fileds" || $('.jAlertsContent').text() == "Aadhar should be 12 digit!" || $('.jAlertsContent').text() == "Aadhar should be 12 digit!Aadhar should be 12 digit!" || $('.jAlertsContent').text() == "Please enter remarks !!!" || $('.jAlertsContent').text() == "Please enter remarks !!!Please enter remarks !!!" || $('.jAlertsContent').text() == "Please enter reject remarks !!!" || $('.jAlertsContent').text() == "Please enter reject remarks !!!Please enter reject remarks !!!") {
	        $('.jAlertsButton').bind("click", jAlertsClose);
	    }
	    //else if ($('.jAlertsContent').contentText == "Job Card Data is submitted against BD ID")
	    //{ $('.jAlertsButton').bind("click", jAlertsClose); }
	    else {
	        window.location.href = window.location.href;
	    }
	});
	
	// Change the color of the button when the the mouse is over the button
	$('.jAlertsButton').hover(function() {
   		$('.jAlertsButton').css({'backgroundColor' : customAlert.buttonHoverColor});
 	}, function() {
    	$('.jAlertsButton').css({'backgroundColor' : customAlert.buttonColor});
 	});


} // ---------- end jAlert() function ---------- //



// This function closes the jAlert. It takes the direction that is came in from, and goes back the same way
function  jAlertsClose() {
	
	// Remove the jAlertsClose() function from the main button
	$('.jAlertsButton').unbind("click", jAlertsClose);
	
	// Switch to determine which way the jAlert should exit the screen ...	
	switch(saveOrigin) {
	
		// If the direction the jAlert came in from was the top, exit back towards the top 
		// and fade out the overlay
		case "top" :
			
			$(".jAlertsOverlay").delay(100).fadeOut();
			
			$(".jAlertsMessage").animate({
				'top'			:		'-100%'
			},function(){
				$(".jAlertsMessage").css({'display' : 'none'});
			});
		break;
		
		// If the direction the jAlert came in from was the bottom, exit back towards the bottom 
		// and fade out the overlay
		case "bottom" :
			$(".jAlertsOverlay").delay(100).fadeOut();
			
			$(".jAlertsMessage").animate({
				'top'			:		'200%'
			},function(){
				$(".jAlertsMessage").css({'display' : 'none'});
			});
		break;
		
		// If the direction the jAlert came in from was the left, exit back towards the left 
		// and fade out the overlay
		case "left" :
			$(".jAlertsOverlay").delay(100).fadeOut();
			
			$(".jAlertsMessage").animate({
				'left'			:		'-100%'
			},function(){
				$(".jAlertsMessage").css({'display' : 'none'});
			});
		break;
		
		// If the direction the jAlert came in from was the left, exit back towards the left 
		// and fade out the overlay
		case "right" :
			$(".jAlertsOverlay").delay(100).fadeOut();
			
			$(".jAlertsMessage").animate({
				'left'			:		'200%'
			},function(){
				$(".jAlertsMessage").css({'display' : 'none'});
			});
		break;
		
	} // end switch

} // ---------- end jAlertsClose() function ---------- //