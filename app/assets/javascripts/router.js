// For more information see: http://emberjs.com/guides/routing/

App.Router.map(function() {
  this.resource('memes', function() {
    this.resource('meme', { path: ':id' }, function() {
      this.route('edit');
    });
  });
});
