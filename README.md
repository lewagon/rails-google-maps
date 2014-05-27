## Testing the app

- fork / clone the repo
- run `bundle install` to install missing gems
- run `rake db:create` and `rake db:migrate` to create the DB and set up its scheme
- `rake db:seed` to populate your database
- `rails s` to test the app


## What's inside ?

Main magic comes from the two following gems in Gemfile

```ruby
gem "geocoder"
gem "gmaps4rails"
```

### How geocoder works ?
Nothing simpler. To use geocoder you just have to pimp the model you want to geocode. Here

```ruby
class Flat < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode
end
```

It assume you have a `flats` table with an `address` column of course.

Then, whenever you create a Flat like `flat = Flat.create(name: "Charming Mansion in Montmartre", address: "12, impasse Marie-Blanche")` it will automatically compute and store this flat's latitude and longitude, accessible with `flat.latitude`, and `flat.longitude`. You can use these new accessors to create custom gmaps iframe, see for example our `views/flats/show.html.erb` view for instance.


### How gmaps4rails works ?

To use it you need:

- to have `underscore.js` file in your `assets/javascript` take the minified version from [here](https://github.com/jashkenas/underscore/blob/master/underscore-min.js)
- load this js + gmaps4rails js in `application.js` with

```
//= require underscore
//= require gmaps/google
```

- then include the script at bottom of your `layout/application.html`

```html
<script src="http://maps.google.com/maps/api/js?v=3.13&amp;sensor=false&amp;libraries=geometry" type="text/javascript"></script>
<script src='http://google-maps-utility-library-v3.googlecode.com/svn/tags/markerclustererplus/2.0.14/src/markerclusterer_packed.js' type='text/javascript'></script>
```

Then all the magic comes in the controller which prepares a hash of custom markers to pass to the template:

```ruby
@hash = Gmaps4rails.build_markers(@flats) do |flat, marker|
  marker.lat flat.latitude
  marker.lng flat.longitude
  marker.json({ title: flat.name })
  marker.infowindow render_to_string(:partial => "/flats/map_box", locals: {flat: flat})
end

```


And then we just use this `@hash` in the `flats/index.html.erb` view in the script

```html
<script type="text/javascript">
$(function(){

  handler = Gmaps.build('Google');
  handler.buildMap({ provider: {}, internal: {id: 'map'}}, function(){
    markers = handler.addMarkers(<%=raw @hash.to_json %>);
    handler.bounds.extendWith(markers);
    handler.fitMapToBounds();
  });

})
</script>
```

And we're done buddies!




