
### 1. Bootstrap the Ember App

```shell
rails g ember:bootstrap
```

### 2. Create An Application Template

`app/assets/javascripts/templates/application.js.hbs`

```html
<h1>Memeories</h1>
```

### 3. Define the Meme Model for Ember
### TODO: change columns

```shell
rails g ember:model Meme name:text started_at:date emoji:boolean medium:text description:text`
```

...generates...

```js
App.Meme = DS.Model.extend({
  name        : DS.attr('string'),
  startedAt   : DS.attr('date'),
  emoji       : DS.attr('boolean'),
  medium      : DS.attr('string'),
  description : DS.attr('string')
});
```

### 3.5 Configure the API Namespace for Ember Data

`app/assets/javascripts/store.js`

```js
// Append to existing file contents
DS.RESTAdapter.reopen({ namespace: 'api/v1' });
```

### 4. List All the Memes

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
<ul>
  {{#each meme in model}}
    <li>
      {{#link-to 'meme' meme}}
        {{meme.name}}
      {{/link-to}}
    </li>
  {{/each}}
</ul>
```

`app/assets/javascripts/templates/application.js.hbs`

```js
// Append to existing file contents
{{outlet}}
```



### 5. View Meme Details

`app/assets/javascripts/router.js`

```js
// Replace some of existing file content
  this.resource('memes', function() {
    this.resource('meme', { path: ':id' });
  });
```
`app/assets/javascript/routes/meme.js`

```js
App.MemeRoute = Ember.Route.extend({
  model: function(params) {
    return this.store.find('meme', params.id);
  }
});
```

`app/assets/javascript/templates/meme.js.hbs`
### TODO: columns, formatting
```html
<table>
  <tr>
    <td>name</td>
    <td>{{name}}</td>
  </tr>
  <tr>
    <td>startedAt</td>
    <td>{{startedAt}}</td>
  </tr>
  <tr>
    <td>emoji</td>
    <td>{{emoji}}</td>
  </tr>
  <tr>
    <td>medium</td>
    <td>{{medium}}</td>
  </tr>
  <tr>
    <td>description</td>
    <td>{{description}}</td>
  </tr>
</table>
```

`app/assets/javascript/templates/memes.js.hbs`

```js
// Append to existing file contents
{{outlet}}
```

### 6. Start the Meme Edit Form

`app/assets/javascript/router.js`

```js
    // Replace some of existing file content
    this.resource('meme', { path: ':id' }, function() {
      this.route('edit');
    });
```

`app/assets/javascript/routes/meme_edit.js`

```js
  App.MemeEditRoute = Ember.Route.extend({});
```

`app/assets/javascript/templates/meme/edit.js.hbs`

```html
<form>
  <div>
    <div>
      <label>Name</label>
      <td>{{input value=name}}</td>
    </div>
    <div>
      <label>Started At</label>
      <td>{{input value=startedAt}}</td>
    </div>
    <div>
      <label>Emoji</label>
      <td>{{input value=emoji}}</td>
    </div>
    <div>
      <label>Medium</label>
      <td>{{input value=medium}}</td>
    </div>
    <div>
      <label>Description</label>
      <td>{{input value=description}}</td>
    </div>
    <div>
      <input type="submit" value="save" />
      <input type="button" value="cancel" />
    </div>
  </div>
</form>
```

`app/assets/javascript/templates/meme.js.hbs`

```js
// Append to existing file contents
{{outlet}}
```

### 7. Save and Cancel Meme Edits

`app/assets/javascript/templates/meme/edit.js.hbs`

```js
    // Replace some of the existing file contents
    <div>
      <input type="submit" value="save" {{action "save"}} />
      <input type="button" value="cancel" {{action "cancel"}} />
    </div>
```

`app/assets/javascript/controllers/meme_edit.js`

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
### 8. Hide Edit Link During Editing

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
  inEditingMode: false,

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

### 9. Emoji Support

`app/assets/javascripts/helpers/emoji.js.erb`

```js
// Note: helper name must include hyphen
Ember.Handlebars.helper('format-emoji', function(text, options) {

  if (Ember.isBlank(text)) { return null; }

  // Use emoji-images.js library
  var emojified = emoji(text, '/assets/emoji', 20);
  return new Ember.Handlebars.SafeString(emojified);
})
```
`app/assets/javascript/templates/meme.js.hbs`

```js
  // Replace some of the existing file contents
  <tr>
    <td>description</td>
    <td>{{format-emoji description}}</td>
  </tr>
```
