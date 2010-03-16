var Hatrack = {
  rack: $('#hatrack'),
  controls: $('#controls'),
  font_size: null,
  sprint_id: null,
  colors: ['yellow','black','green','red','white'] ,
  init: function() {
    $('#current_name').bind('click', Hatrack.showSprints);

    $('.add_hat').bind('click', Hatrack.determineColor);

    $('.toggle').bind('click', Hatrack.toggleColor);

    $('.fontSize').bind('click', Hatrack.fontSize);

    $('.date_input').datepicker({dateFormat: 'yy-mm-dd'});

    $('#edit_sprint').bind('click', Hatrack.editSprint);
    $('#new_sprint').bind('click', Hatrack.newSprint);
    $('.cancel').bind('click', Hatrack.cancelEdit);

    $('.promote').bind('click', Hatrack.promote);

    $('#toggle_help').bind('click', function(){$('#hints').toggle()} );

    if (Hatrack.font_size) {
      $('#hatrack').css('font-size', Hatrack.font_size);
    }

    $('html').keydown(Hatrack.keyWatcher);
    Hatrack.setup();
  },
  setup: function(editable, hat) {
    for (var i in Hatrack.colors) {
      $('.hat.e.' + Hatrack.colors[i]).editable('/hats/update?sprint_id=' + Hatrack.sprint_id + '&type=' + Hatrack.colors[i], {
        type: 'textarea',submit: 'Save',cancel: 'Cancel',
        onblur: 'ignore',onedit:Hatrack.onEdit , onreset: Hatrack.setup,
        placeholder: 'Enter a hat'
      });
    }

    var green_opts = {
      type: 'textarea',submit: 'Save',cancel: 'Cancel', onblur: 'ignore',onedit:Hatrack.onEdit,
      placeholder: 'Add a green hat',onreset: Hatrack.setup }

    $('.green_hat .text').editable('/hats/update_green_hat?sprint_id=' + Hatrack.sprint_id, green_opts);
    green_opts.placeholder = 'Add a green hat owner'
    $('.green_hat .owner').editable('/hats/update_green_hat?sprint_id=' + Hatrack.sprint_id, green_opts);


    Hatrack.screen_dirty = $('.hat textarea').length > 1;

  },

  determineColor:function(event) {
    Hatrack.addHat($(event.target).val());
  },
  addHat: function(color) {
    Hatrack.resetNewHat();

    if ($('.hat.new.' + color).length > 0) {
      $('.hat.new.' + color).click();
      return false;
    }

    var id = Math.floor(Math.random() * 1111)

    $('#' + color + ' ul').prepend('<li class="hat_item"><div class="hat new ' + color + '" id="hat_' + id + '"></div></li>');
    var new_hat = $('#hat_' + id);
    new_hat.editable('/hats/create?sprint_id=' + Hatrack.sprint_id + '&type=' + color, {
      type: 'textarea',submit: 'Save',cancel: 'Cancel',onedit:Hatrack.onNewEdit,
      onreset: Hatrack.setup, onblur: 'ignore',placeholder: 'Enter a hat',
      callback:function(value, settings) {
        new_hat.parent('li').replaceWith(value);
        Hatrack.setup();
      }});

    new_hat.click();
    Hatrack.screen_dirty = true;
    return false;
  },

  onNewEdit:function(editable, hat) {
    $(hat).html('');
  },
  onEdit:function(editable, hat) {
    Hatrack.screen_dirty = true
  },

  toggleColor: function(event) {
    var color = $(event.target).attr('data-color');
    $('#' + color).toggle();

    $('.rack:visible').each(function(i, e) {
      $('.toggle.' + e.id).removeClass('disabled');
    });
    $('.rack:hidden').each(function(i, e) {
      $('.toggle.' + e.id).addClass('disabled');
    });

    $('.rack:visible').width(100/$('.rack:visible').length+'%');

    return false;
  },


  view:function(event) {
    $('.view').attr('style', null);
    $('.view').removeClass('view');
    $('.note').bind('click', Hatrack.view);

    $(event.target).unbind('click');
    $(event.target).animate({position:'absolute',width:'400px',height: '400px',  left: 0,right: 0,  top: 0,bottom: 0, opacity: 1,margin: '0 auto'}).addClass('view');
  },

  save:function(hat, value, settings) {
    var type = this.className.split(' ')[1];
    var value = this.innerHTML;
    $.post('/hats/create', {'hat[type]': type, 'hat[body]': value});
    Hatrack.screen_dirty = $('.hat textarea').length > 0;

    return  value;
  },

  fontSize: function(event) {
    var dir = event.target.className.split(' ')[1];
    switch (dir) {
      case 'reset':
        $('#hatrack').attr('style', null)
        break;
      case 'up':
        $('#hatrack').css('font-size', parseInt($('#hatrack').css('font-size')) + 1);
        break;
      case 'down':
        $('#hatrack').css('font-size', parseInt($('#hatrack').css('font-size')) - 1);
        break;
    }
    $.post('/sprints/set_font_size', {size:parseInt($('#hatrack').css('font-size')) });
  },

  editSprint: function(event) {
    $('#new_sprint_form').hide();
    $('#edit_sprint_form').show();
    Hatrack.screen_dirty = true;
  },
  cancelEdit: function(event) {
    $('.form').hide();
    Hatrack.screen_dirty = false;
    return false;
  },
  newSprint: function(event) {
    $('#edit_sprint_form').hide();
    $('#new_sprint_form').show();
    $('#new_sprint_form input:text:first').focus()
    Hatrack.screen_dirty = true;
  },
  screen_dirty: false,
  new_hat_enabled: false,
  keyWatcher: function(event) {
    if ( event.keyCode == 27){
      Hatrack.resetAllPopUps();
      return;
    }

    if ( (!Hatrack.screen_dirty && $.inArray( event.keyCode , [72,78] ) > -1 ) ||
         (event.altKey && $.inArray( event.keyCode , [72,78] ) > -1 ) ) {
      $('#new_hat').show();
      Hatrack.new_hat_enabled = true;
      return false;
    }
    if (Hatrack.new_hat_enabled) {
      var color = null;
      switch (event.keyCode) {
        case 66: event.target.parentNode.className
          color = "black";
          break;
        case 89:
          color = "yellow";
          break;
        case 27:
          Hatrack.resetNewHat();
          return false
          break;
      }
      if (color) {
        Hatrack.addHat(color);
        Hatrack.resetNewHat();
        return false;

      }

    }
  },
  resetNewHat: function() {
    $('#new_hat').hide();
    Hatrack.new_hat_enabled = false;
  },

  resetAllPopUps: function(){
    Hatrack.resetNewHat();
    Hatrack.cancelEdit();
    Hatrack.hideSprints();
    $('#hints').hide();

  },

  showSprints:function(event) {
    $('#sprints').show();
    $('body').bind('click', Hatrack.resetWindows);
  },

  hideSprints:function(){
    $('#sprints').hide();
    $('body').unbind('click', Hatrack.resetWindows);
  },
  resetWindows:function(event) {
    if (event.target.id != 'current_name') {
      Hatrack.hideSprints();
    }
  },

  promote: function(event) {
    $.ajax({url:'/hats/promote/' + $(event.target).val(), dataType:'json',
      data:{sprint_id: Hatrack.sprint_id},
      success: function(data) {
        $.jGrowl(data.msg);
      },
      error: function(request,data){
        $.jGrowl('Please Start a New Sprint');
      }
    });
  }
}



