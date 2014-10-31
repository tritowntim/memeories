// for more details see: http://emberjs.com/guides/models/defining-models/

App.Meme = DS.Model.extend({
  name: DS.attr('string'),
  funny: DS.attr('boolean'),
  description: DS.attr('string'),
  emojiPattern: DS.attr('string')
});
