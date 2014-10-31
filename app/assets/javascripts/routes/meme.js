App.MemeRoute = Ember.Route.extend({
  model: function(params) { return this.store.find('meme', params.id); }
});
