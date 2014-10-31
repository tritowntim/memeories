App.MemesRoute = Ember.Route.extend({
  model: function() { return this.store.find('meme'); }
});
