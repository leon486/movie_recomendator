$('document').ready(function(){
        $( "#release_date" ).datepicker({ minDate: '-100Y', maxDate: "+2Y", dateFormat: "yy-mm-dd", changeMonth: true,
        changeYear: true });
		
	    $(function() {
	      $( "#configuration_dialog" ).dialog({autoOpen: false,modal:true, title: "Configuración",width:700, height:400,  buttons: [
		      {
				  
		        text: "Actualizar",
				  id: "configuration_save",
		        class: "btn btn-primary",
		        click: function() {
				  $.ajax({ url: "/configs/save?notification_status="+$('#notification_status').is(':checked')+"&time="+$('#time').val()+"&time_type="+$('#time_type').val()+"&emails="+$('#emails').val(),
				    type: 'POST',
				    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
				    success: function(data) {
						//alert(data);
				    }
				});
		          $( this ).dialog( "close" );
		        }
		      },{
      text: "Cancelar",
	  id:"configuration_cancel",
      click: function() {
        $( this ).dialog( "close" );
      }
    }
  ]});
	    });
		
		$("#configuration_button").click(function(){
			$( "#configuration_dialog" ).dialog( "open" );
		});
		
		//Movie deactivation
		$("body").on('click','.movie_delete',function(){
			var tr = $(this).closest('tr')
			var id = tr.attr('id').split('_')[1];
		  $.ajax({ url: "/movies/deactivate?id="+id,
		    type: 'POST',
		    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
		    success: function(data) {
				tr.fadeOut('fast', function() {
					$(this).remove(); 
	 				if($('#movie_table tbody tr').length < 1){
	 					$("#movie_table").append('<tr class="movie_empty">	<td colspan="7">	-No hay pel&iacute;culas registradas-	</td></tr>');
	 				}
				});
				
		    }
		});
		return false;
		});
		
		//Auto get release date
		$("#get_release_date").click(function(){
			  $.ajax({ url: "/movies/get_release_date?title="+$('#title').val()+"&year="+$('#year').val(),
			    type: 'POST',
			    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
			    success: function(data) {
					$('#release_date').val(data.release_date);
			    }
			});
			return false;
		});
		
		
		//add movie
		$("#add_movie").click(function(){
			  $.ajax({ url: "/movies/add_movie?title="+$('#title').val()+"&year="+$('#year').val()+"&release_date="+$('#release_date').val(),
			    type: 'POST',
			    beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
			    success: function(data) {
						//alert(data.movie.title);
						//get row
						$(".movie_empty").remove();
						
						if($("#movie_"+data.movie.id).length>0){
							$("#movie_"+data.movie.id).replaceWith('<tr id="movie_'+data.movie.id+'"><td> '+data.movie.id+'</td>	<td><img class="movie_poster" src="'+data.poster+'"></td><td>'+data.movie.title+'</td><td>'+data.movie.year+'</td><td>'+data.movie.release_date+'</td><td></td><td><button aria-expanded="false" aria-haspopup="true" class="movie_delete btn btn-danger dropdown-toggle" type="button">Eliminar</button></td></tr>');
						}else{
						
							$("#movie_table").append('<tr id="movie_'+data.movie.id+'"><td> '+data.movie.id+'</td>	<td><img class="movie_poster" src="'+data.poster+'"></td><td>'+data.movie.title+'</td><td>'+data.movie.year+'</td><td>'+data.movie.release_date+'</td><td></td><td><button aria-expanded="false" aria-haspopup="true" class="movie_delete btn btn-danger dropdown-toggle" type="button">Eliminar</button></td></tr>');
						}
			    }
			});
			return false;
		});
	});