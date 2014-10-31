App.MemeController = Ember.ObjectController.extend({
  editingMode: false,

  beginEditing: function() { this.set('editingMode', true); },
  endEditing: function() { this.set('editingMode', false); }
});
