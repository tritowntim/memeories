
#### 1. Bootstrap the Ember App

```shell
rails g ember:bootstrap
```

#### 2. Create An Application Template

`app/assets/javascripts/templates/application.js.hbs`

```html
<h1>Memeories</h1>
```

#### 3. Define the Meme Model for Ember

```shell
rails g ember:model Meme name:text funny:boolean description:text emoji_pattern:text
```

...generates...

```js
App.Meme = DS.Model.extend({
  name         : DS.attr('string'),
  funny        : DS.attr('boolean'),
  description  : DS.attr('string'),
  emojiPattern : DS.attr('string')
});
```

#### 3.5 Configure the API Namespace for Ember Data

`app/assets/javascripts/store.js`

```js
// Append to existing file contents
DS.RESTAdapter.reopen({ namespace: 'api/v1' });
```

#### 4. List All the Memes

`app/assets/javascripts/router.js`

```js
// Replace existing file contents
App.Router.map(function() {
  this.resource('memes');
});
```

`app/assets/javascripts/routes/memes.js`

```js
App.MemesRoute = Ember.Route.extend({
  model: function() {
    return this.store.find('meme');
  }
});
```

`app/assets/javascripts/templates/memes.js.hbs`

```html
<div class="memes">
  <ul>
    {{#each meme in model}}
      <li>
        {{meme.name}}
      </li>
    {{/each}}
  </ul>
</div>
```

`app/assets/javascripts/templates/application.js.hbs`

```js
// Append to existing file contents
<div id="container">
  {{outlet}}
</div>
```


#### 5. View Meme Details

`app/assets/javascripts/router.js`

```js
// Replace some of existing file content
  this.resource('memes', function() {
    this.resource('meme', { path: ':id' });
  });
```
`app/assets/javascripts/routes/meme.js`

```js
App.MemeRoute = Ember.Route.extend({
  model: function(params) {
    return this.store.find('meme', params.id);
  }
});
```

`app/assets/javascripts/templates/meme.js.hbs`
```html
<div class="meme">
  <div>
    <div>Meme Name</div>
    <div>{{name}}</div>
  </div>
  <div>
    <div>Funny</div>
    <div>{{funny}}</div>
  </div>
  <div>
    <div>Description</div>
    <div>{{description}}</div>
  </div>
  <div>
    <div>Emoji</div>
    <div>{{emojiPattern}}</div>
  </div>
</div>
```

`app/assets/javascripts/templates/memes.js.hbs`

```js
// Replace some of existing file contents
<li>
  {{#link-to 'meme' meme}}
    {{meme.name}}
  {{/link-to}}
</li>

// Append to existing file contents
{{outlet}}
```

#### 6. Start the Meme Edit Form

`app/assets/javascripts/router.js`

```js
    // Replace some of existing file content
    this.resource('meme', { path: ':id' }, function() {
      this.route('edit');
    });
```

`app/assets/javascripts/routes/meme_edit.js`

```js
  App.MemeEditRoute = Ember.Route.extend({});
```

`app/assets/javascripts/templates/meme/edit.js.hbs`

```html
<form class="meme-edit">
  <div>
    <div><label>Name</label></div>
    <div>{{input value=name}}</div>
  </div>
  <div>
    <div><label>Description</label></div>
    <div>{{input value=description}}</div>
  </div>
  <div>
    <div><label>Funny</label></div>
    <div>{{input type="checkbox" checked=funny}}</div>
  </div>
  <div>
    <div><label>Emoji</label></div>
    <div>{{input value=emojiPattern}}</div>
  </div>
  <div>
    <div></div>
    <div>
      <input type="submit" value="save" />
      <input type="button" value="cancel" />
    </div>
  </div>
</form>
```

`app/assets/javascripts/templates/meme.js.hbs`

```js
// Append to existing file contents
{{outlet}}
```

#### 7. Save and Cancel Meme Edits

`app/assets/javascripts/templates/meme/edit.js.hbs`

```js
    // Replace some of the existing file contents
    <div>
      <div></div>
      <div>
        <input type="submit" value="save" {{action "save"}} />
        <input type="button" value="cancel" {{action "cancel"}} />
      </div>
    </div>
```

`app/assets/javascripts/controllers/meme_edit.js`

```js
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
```
#### 8. Hide Edit Link During Editing

`app/assets/javascripts/templates/meme.js.hbs`

```js
// Replace some of the existing file contents
{{#unless editingMode}}
  {{#link-to 'meme.edit'}}
    edit
  {{/link-to}}
{{/unless}}
```

`app/assets/javascripts/controllers/meme.js`

```js
App.MemeController = Ember.ObjectController.extend({
  editingMode: false,

  beginEditing: function() { this.set('editingMode', true); },
  endEditing: function() { this.set('editingMode', false); },
});
```

`app/assets/javascripts/routes/meme_edit.js`

```js
// Replace entire file contents
App.MemeEditRoute = Ember.Route.extend({
  activate: function() { this.controllerFor('meme').beginEditing(); },
  deactivate: function() { this.controllerFor('meme').endEditing(); }
});
```

#### 9. Emoji Support

`app/assets/javascripts/helpers/emoji.js.erb`

```js
// Note: helper name must include hyphen
Ember.Handlebars.helper('format-emoji', function(text, options) {

  if (Ember.isBlank(text)) { return null; }

  // Use emoji-images.js library
  var emojified = emoji(text, '/assets/emoji', 20);
  return new Ember.Handlebars.SafeString(emojified);
});
```
`app/assets/javascripts/templates/meme.js.hbs`

```js
  // Replace some of the existing file contents
  <div>
    <div>Emoji</div>
    <div>{{format-emoji emojiPattern}}</div>
  </div>  
```
