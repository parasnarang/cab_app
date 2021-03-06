
var time,source,destination,other_destination;
function onSelectedValueChange(ddl_id,txt_id,txt2_id,guest_house_id)
{
    var ddl_list = document.getElementById(ddl_id);
    if  (ddl_list.value=="Other")
    {
        document.getElementById(txt_id).type = "text";
        document.getElementById(txt_id).disabled=false;
        document.getElementById(txt_id).focus()
        document.getElementById(txt2_id).type = "hidden";
        document.getElementById(txt2_id).disabled=true;
        $('#'+guest_house_id).hide();
    }
    else if (ddl_list.value=="Airport")
    {
        document.getElementById(txt2_id).type = "text";
        document.getElementById(txt2_id).disabled=false;
        document.getElementById(txt2_id).focus()
        document.getElementById(txt_id).type = "hidden";
        document.getElementById(txt_id).disabled=true;
        $('#'+guest_house_id).hide();
    }
    else if (ddl_list.value=="Guest House")
    {
        $('#'+guest_house_id).show();
        document.getElementById(guest_house_id).disabled=false;
        document.getElementById(txt_id).type = "hidden";
        document.getElementById(txt_id).disabled=true;
        document.getElementById(txt2_id).type = "hidden";
        document.getElementById(txt2_id).disabled=true;
    }
    else
    {
        document.getElementById(txt_id).type = "hidden";
        document.getElementById(txt_id).disabled=true;
        document.getElementById(txt2_id).type = "hidden";
        document.getElementById(txt2_id).disabled=true;
        $('#'+guest_house_id).hide();
        document.getElementById(guest_house_id).disabled=true;
    }
}

$(document).ready(function() {
    $('#guest_house_source').hide();
    $('#guest_house_destination').hide();
    if ($('#source').val() == 'Other')
    {
        $('#other_source').attr('type',"text");
        $('#other_source').attr('disabled',false);
    }
    if ($('#source').val() == 'Airport')
    {
        $('#flight_number_source').attr('type',"text");
        $('#flight_number_source').attr('disabled',false);
    }

    if ($('#destination').val() == 'Other')
    {
        $('#other_destination').attr('type',"text");
        $('#other_destination').attr('disabled',false);
    }
    if ($('#destination').val() == 'Airport')
    {
        $('#flight_number_destination').attr('type',"text");
        $('#flight_number_destination').attr('disabled',false);
    }

    $('#pick_up_time').focus(function(){
        time = this;
        if($('#pick_up_time').val() != "")
        {
            $('#pick_up_time').timepicker({
                minuteStep: 30,
                defaultTime: $('#pick_up_time').val(),
                showInputs: false,
                disableFocus: true
            });
        }
        else if($('#pick_up_time').val() == "")
        {
            $('#pick_up_time').val("");
            $('#pick_up_time').timepicker({
                minuteStep: 30,
                defaultTime: 'current',
                showInputs: false,
                disableFocus: true
            });
        }
    });

    $('.date_picker').keypress(function(event) {event.preventDefault();});
    $('#pick_up_date').keypress(function(event) {event.preventDefault();});
    $('#pick_up_date').datepicker({dateFormat: "dd/mm/yy",minDate: 0});

    $('#from_date').datepicker({
        dateFormat: "dd/mm/yy",
        onSelect: function(selected) {
            $("#to_date").datepicker("option","minDate", selected)

        }
    });
    $('#to_date').datepicker({
        dateFormat: "dd/mm/yy",
        onSelect: function(selected) {
            $("#from_date").datepicker("option","maxDate", selected)
        }
    });

    $("#pick_up_time").keypress(function(event) {event.preventDefault();});

    $('.content-main').css('min-height', $(document).height()-220)
    $(document).on('resize',function(){
        $('.content-main').css('min-height', $(document).height()-120)
    })

    $('#source').change(function(){
        source = this;
        if ($('#source').val() != 'Select')
        {
            $(this).css('color', 'black');
        }
        source.setCustomValidity("");
    });

    $('#destination').change(function(){
        destination = this;
        if ($('#destination').val() != 'Select')
        {
            $(this).css('color', 'black');
        }
        destination.setCustomValidity("");

    });

    $('#other_destination').blur(function(){
        other_destination = this;
    });

    $('#to_date').blur(function(){
        to_date = this;
    });


    $('#Create_cab_request').click(function(){
        current_dateTime = new Date();
        var dateTimeString = $('#pick_up_date').val()+" "+$('#pick_up_time').val();
        var split_array = dateTimeString.split("/");
        var formattedDateTime = new Date(split_array[1] + "/" + split_array[0] + "/" + split_array[2]);
        if (current_dateTime > formattedDateTime)
        {
           time.setCustomValidity("Time can't be less than current time");
        }
        else
        {
           time.setCustomValidity("");
        }

        if(($('#source').val() == $('#destination').val()) && ($('#destination').val() != 'Other'))
        {
           destination.setCustomValidity("destination can't be same as source");
        }
        else if(($('#source').val() == 'Other') && ($('#other_source').val() == ($('#other_destination').val())))
        {
           destination.setCustomValidity("");
           other_destination.setCustomValidity("destination can't be same as source");
        }
        else
        {
           destination.setCustomValidity("");
           other_destination.setCustomValidity("");
        }
    });

    $("#filter_by").change(function(){
        $("#table").hide();
        $("#xls_link").hide();
        $("hr").hide();
    });

    edit_message = $.find('.edit_message');
    update_message = $.find('.update_message');
    update_button = $.find('.update_button');

    $.each(edit_message,function(index,value) {
        $(edit_message[index]).click(function () {
            $(update_message[index]).attr('disabled', false);
            $(update_message)[index].focus();
            $(update_button)[index].style.display="inline";
            $(update_button[index]).attr('disabled', false);
        });
    });

    $.each(update_button,function(index,value) {
        $(update_button[index]).click(function () {
            var d = {
                req_id: $(this).data('id'),
                new_status: $(update_message[index]).val()
            }
            $.ajax({
                url: '/support_centers/update_cab_request_status/',
                data: d
            });
            $(update_message[index]).attr('disabled', true);
            $(update_button[index]).attr('disabled', true);
            $(update_button)[index].style.display="none";
        });
    });
});



