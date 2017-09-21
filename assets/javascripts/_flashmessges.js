$(document).on('turbolinks:load', function(){
    $(".flash").delay(2000).slideUp(500, function(){
          $(".flash").alert('close');
      });
    });
