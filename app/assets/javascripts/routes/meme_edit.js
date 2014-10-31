App.MemeEditRoute = Ember.Route.extend({
  activate: function() { this.controllerFor('meme').beginEditing(); },
  deactivate: function() { this.controllerFor('meme').endEditing(); }
});
