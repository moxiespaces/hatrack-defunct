var Hatrack = {
  rack: $('#hatrack'),
  controls: $('#controls'),
  font_size: null,
  sprint_id: null,
  colors: ['yellow','black','green','red','white'] ,
  init: function(){
    $('#current_name').bind('click',Hatrack.showSprints);

    $('.add_hat').bind('click', Hatrack.addHat);

    $('.toggle').bind('click', Hatrack.toggleColor);

    $('.fontSize').bind('click', Hatrack.fontSize);

    $('.date_input').datepicker({dateFormat: 'yy-mm-dd'});

    $('#edit_sprint').bind('click', Hatrack.editSprint);

    if (Hatrack.font_size) {
      $('#hatrack').css('font-size', Hatrack.font_size);
    }

    $('body').keydown(Hatrack.keyWatcher);
    $('body').bind('click', Hatrack.resetWindows);
    Hatrack.setup();
  },
  setup: function(editable,hat) {
    for (var i in Hatrack.colors) {
      $('.hat.e.' + Hatrack.colors[i]).editable('/hats/update?sprint_id=' + Hatrack.sprint_id + '&type=' + Hatrack.colors[i], {
        type: 'textarea',submit: 'Save',cancel: 'Cancel', onblur: 'ignore',onedit:Hatrack.onEdit , onreset: Hatrack.setup});
    }

    $('.green_hat div').editable('/hats/update_green_hat?sprint_id=' + Hatrack.sprint_id, {
      type: 'textarea',submit: 'Save',cancel: 'Cancel', onblur: 'ignore',onedit:Hatrack.onEdit, onreset: Hatrack.setup });


    Hatrack.screen_dirty = $('.hat textarea').length > 1;

  },

  addHat: function(event) {
    var color = event.target.parentNode.className.split(' ')[1];
    if ($('.hat.new.' + color).length > 0) {
      $('.hat.new.' + color).click();
      return false;
    }

    var id = Math.floor(Math.random() * 1111)

    $('#' + color + ' ul').prepend('<li class="hat_item"><div class="hat new ' + color + '" id="hat_' + id + '">Enter a hat</div></li>');
    var new_hat = $('#hat_' + id);
    new_hat.editable('/hats/create?sprint_id=' + Hatrack.sprint_id + '&type=' + color, {
      type: 'textarea',submit: 'Save',cancel: 'Cancel',onedit:Hatrack.onNewEdit, onreset: Hatrack.setup, onblur: 'ignore', callback:function(value, settings) {
        new_hat.parent('li').replaceWith(value);
        Hatrack.setup();
      }});

    new_hat.click();
    Hatrack.screen_dirty = true;
    return false;
  },

  onNewEdit:function(editable,hat){
    $(hat).html('');
  },
  onEdit:function(editable,hat){
    Hatrack.screen_dirty = true
  },

  toggleColor: function(event) {
    $('#' + event.target.className.split(' ')[1]).toggle();
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
    $(event.target).parent('#current_sprint').addClass('edit');
  },

  screen_dirty: false,
  new_hat_enabled: false,
  mock_add_event: {target:{parentNode:{className:""}}},
  keyWatcher: function(event) {
    if ((!Hatrack.screen_dirty && event.keyCode == 72) ||
        (event.altKey && event.keyCode == 72 )) {
      $('#new_hat').addClass('enabled');
      Hatrack.new_hat_enabled = true;
      return false;
    }

    if (Hatrack.new_hat_enabled) {
      var mock_event = null;
      switch (event.keyCode) {
        case 66: event.target.parentNode.className
          mock_event = Hatrack.mock_add_event;
          mock_event.target.parentNode.className = "add_hat black";
          break;
        case 89:
          mock_event = Hatrack.mock_add_event;
          mock_event.target.parentNode.className = "add_hat yellow";
          break;
        case 27:
          Hatrack.resetNewHat();
          return false
          break;
      }
      if (mock_event) {
        Hatrack.addHat(mock_event);
        Hatrack.resetNewHat();
        return false;

      }

    }
  },
  resetNewHat: function() {
    $('#new_hat').removeClass('enabled');
    Hatrack.new_hat_enabled = false;
  },

  showSprints:function(event){
    $('#sprints').addClass('enable');
  },

  resetWindows:function(event){
    if ( event.target.id != 'current_name' ){
      $('#sprints').removeClass('enable');
    }
  }
}



