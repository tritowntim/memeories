App.MemeEditController = Ember.ObjectController.extend({
  actions: {

    save: function() {
      var self = this;
      this.get('model').save().then(function() {
        self.transitionToRoute('meme');
      });
    },

    cancel: function() {
      this.get('model').rollback();
      this.transitionToRoute('meme');
    }
  }
});
