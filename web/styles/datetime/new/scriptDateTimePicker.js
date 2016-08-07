/*
  jQuery Document ready
*/
$(function()
{
	$('#basic_example_1').datetimepicker(
	{
		/*
			timeFormat
			Default: "HH:mm",
			A Localization Setting - String of format tokens to be replaced with the time.
		*/
		timeFormat: "hh:mm tt",
		/*
			hourMin
			Default: 0,
			The minimum hour allowed for all dates.
		*/
		hourMin: 8,
		/*
			hourMax
			Default: 23, 
			The maximum hour allowed for all dates.
		*/
		hourMax: 16,
		/*
			numberOfMonths
			jQuery DatePicker option
			that will show two months in datepicker
		*/
		numberOfMonths: 2,
		/*
			minDate
			jQuery datepicker option 
			which set today date as minimum date
		*/
		minDate: 0,
		/*
			maxDate
			jQuery datepicker option 
			which set 30 days later date as maximum date
		*/
		maxDate: 30
	});
	
	/*
		below code just enable time picker.
	*/	
	$('#basic_example_2').timepicker();
});