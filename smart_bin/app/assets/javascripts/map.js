
    console.log("Script Starts");
    var defaultCenter = [101.623, 3.135];
    var truckLocation = [101.625871, 3.138663]; //starting point
    var depoLocation = [101.625871, 3.138663]; //starting point (purposely doubled)
    // var lastQueryTime = 0;
    var lastAtRestaurant = 0;
    var keepTrack = [];
    // var currentSchedule = [];
    var currentRoute = null;
    var pointHopper = {};
    var pause = true;
    // var speedFactor = 50;

    // Add your access token
    mapboxgl.accessToken = 'pk.eyJ1IjoiZXpsYW5tb2hzZW4iLCJhIjoiY2psb3pqZjhpMXRrMTNrcnozYXhqZjJoYSJ9.-xdBDdcC7EEu6uBDl6NL6Q';
    // Initialize a map
    var map = new mapboxgl.Map({
      container: 'map', // container id
      style: 'mapbox://styles/mapbox/streets-v9', // stylesheet location
      center: defaultCenter, // starting position
      zoom: 14 // starting zoom
    });

    // For warehouse
    var depo = turf.featureCollection([turf.point(depoLocation)]);
    // Create an empty GeoJSON feature collection for drop-off locations
    var pickups = turf.featureCollection([]);
    // Create an empty GeoJSON feature collection, which will be used as the data source for the route before users add any new data
    var nothing = turf.featureCollection([]);
    // Point for animation
    var point = {
        "type": "FeatureCollection",
        "features": [{
            "type": "Feature",
            "properties": {},
            "geometry": {
                "type": "Point",
                "coordinates": truckLocation
            }
        }]
    };

  
    
    map.on('load', function() {

      // For the truck marker
      var marker = document.createElement('div');
      marker.classList = 'truck';
      // Create a new marker for truck
      truckMarker = new mapboxgl.Marker(marker)
      .setLngLat(truckLocation)
      .addTo(map);
      // Create a circle layer for next academy
      map.addLayer({
        id: 'depo',
        type: 'circle',
        source: {
          data: depo,
          type: 'geojson'
        },
        paint: {
          'circle-radius': 20,
          'circle-color': 'white',
          'circle-stroke-color': '#3887be',
          'circle-stroke-width': 3
        }
      });
      // Create a symbol layer on top of circle layer for next academy
      map.addLayer({
        id: 'depo-symbol',
        type: 'symbol',
        source: {
          data: depo,
          type: 'geojson'
        },
        layout: {
          'icon-image': 'mountain-15',
          'icon-size': 1
        },
        paint: {
          'text-color': '#3887be'
        }
      });
      // For Extra on-click pickups
      map.addLayer({
        id: 'pickups-symbol',
        type: 'symbol',
        source: {
          data: pickups,
          type: 'geojson'
        },
        layout: {
          'icon-allow-overlap': true,
          'icon-ignore-placement': true,
          'icon-image': 'laundry-15',
          'icon-size': 1.2
        }
      });
      // Layer of empty source for routing
      map.addSource('route', {
        type: 'geojson',
        data: nothing
      });
      // Layer for route
      map.addLayer({
        id: 'routeline-active',
        type: 'line',
        source: 'route',
        layout: {
          'line-join': 'round',
          'line-cap': 'round'
        },
        paint: {
          'line-color': 'blue',
          'line-width': {
            base: 1,
            stops: [[12, 3], [22, 12]]
          }
        }
      }, 'waterway-label');
      // Layer to add direction arrows to routes
      map.addLayer({
        id: 'routearrows',
        type: 'symbol',
        source: 'route',
        layout: {
          'symbol-placement': 'line',
          'text-field': '▶',
          'text-size': {
            base: 1,
            stops: [[12, 24], [22, 60]]
          },
          'symbol-spacing': {
            base: 100,
            stops: [[12, 30], [22, 160]]
          },
          'text-keep-upright': false
        },
        paint: {
          'text-color': '#3887be',
          'text-halo-color': 'hsl(55, 11%, 96%)',
          'text-halo-width': 3
        }
      }, 'waterway-label');
      // Layer and source for animation
      map.addSource('animateRoute', {
        type: 'geojson',
        data: point
      });
      map.addLayer({
          "id": "point",
          "source": "animateRoute",
          "type": "symbol",
          "layout": {
              "icon-image": "car-15",
              'icon-size': 2,
              "icon-rotate": ["get", "bearing"],
              "icon-rotation-alignment": "map",
              "icon-allow-overlap": true,
              "icon-ignore-placement": true
          }
      });
      // On load, show location of dustbins and project route immediately.
      // Will receive input from backend on which bins.
      var geojson;

      $.ajax({
        dataType: 'text',
        url: 'users.json',
        success: function(data) {
          
          var activebins = new Array();
          geojson = $.parseJSON(data);
          

          // Update activebins
          l  = geojson.length;
          for (x = 0; x < l; x++){
            // Pickup Only Dustbins where > 70%
            if (geojson[x].properties.level >= 70){
            activebins[x] = {lng: geojson[x].geometry.coordinates[0], lat: geojson[x].geometry.coordinates[1]};
            }
          }

          // Set Dropoff for activebins
          i  = activebins.length;
          for (x = 0; x < i; x++){
            newDropoff(activebins[x]);
          }
          updatepickups(pickups);
          // Make a request to the Optimization API'
          callAjax(activebins)

          // Update Marker
          updatemarker(geojson);
          }

        });
      
      });
      

    

      function callAjax(activebins) {
        $.ajax({
          method: 'GET',
          url: assembleQueryURL(),
        }).done(function(data) {
          console.log(data);
          // Create a GeoJSON feature collection
          var routeGeoJSON = turf.featureCollection([turf.feature(data.trips[0].geometry)]);
          // If there is no route provided, reset
          if (!data.trips[0]) {
            routeGeoJSON = nothing;
          } else {
            // Update the `route` source by getting the route source
            // and setting the data equal to routeGeoJSON
            map.getSource('route')
              .setData(routeGeoJSON);
          }
          // Breaking routeGeoJSON into smaller frames
          var counter = 0;
          var steps = 3000;
          var lineDistance = turf.lineDistance(routeGeoJSON.features[0], {units: 'kilometers'});
          var road = []
          
          for (var i = 0; i < lineDistance; i += lineDistance / steps) {
              var segment = turf.along(routeGeoJSON.features[0], i, {units: 'kilometers'});
              road.push(segment.geometry.coordinates);
          }
          routeGeoJSON.features[0].geometry.coordinates = road
          // Animation function within Ajax
          function animate() {
          // Update point geometry to a new position based on counter denoting
          // the index to access the arc.
          point.features[0].geometry.coordinates = routeGeoJSON.features[0].geometry.coordinates[counter];
          // Calculate the bearing to ensure the icon is rotated to match the route arc
          // The bearing is calculate between the current point and the next point, except
          // at the end of the arc use the previous point and the current point
          point.features[0].properties.bearing = turf.bearing(
              turf.point(routeGeoJSON.features[0].geometry.coordinates[counter >= steps ? counter - 1 : counter]),
              turf.point(routeGeoJSON.features[0].geometry.coordinates[counter >= steps ? counter : counter + 1])
          );
          // Update the source with this new data.
          // map.getSource('point').setData(point);
            map.getSource('animateRoute')
              .setData(point);
          // Request the next frame of animation so long the end has not been reached.
          if (counter < steps) {
            requestAnimationFrame(animate);
          } else {
            // if counter is more than steps (steps is also equivalent to index of coordinates)
            counter = 0
            // Enable button when animation ends so button can be clicked again.
            document.getElementById('simulate').removeAttribute("disabled")
          }
          counter = counter + 1;
        }
        document.getElementById('simulate').addEventListener('click', function() {
          // Disabled button after clicked once.
          this.setAttribute("disabled", "true")
          // Start the animation.
          animate(counter);
        })
        // Passing data into summary to show the distance travelled and duration it will take.
        // data.trips[0].distance is 10404.8
        // data.trips[0].duration is 1777.4999999999998
        document.getElementById('summary').innerHTML = "Your journey today will take " + ((data.trips[0].duration)/60).toFixed(0) + " minutes for " + ((data.trips[0].distance)/1000).toFixed(2) + " km to collect " + activebins.length + " bins!"
        });
      }
      // Here you'll specify all the parameters necessary for requesting a response from the Optimization API
      function assembleQueryURL() {
        // Store the location of the truck in a variable called coordinates
        var coordinates = [truckLocation];
        var distributions = [];
        keepTrack = [truckLocation];
        // Create an array of GeoJSON feature collections for each point
        var restJobs = objectToArray(pointHopper);
        // If there are actually orders from this restaurant
        if (restJobs.length > 0) {
          // Check to see if the request was made after visiting the restaurant
          var needToPickUp = restJobs.filter(function(d, i) {
            return d.properties.orderTime > lastAtRestaurant;
          }).length > 0;
          // If the request was made after picking up from the restaurant,
          // Add the restaurant as an additional stop
          if (needToPickUp) {
            var restaurantIndex = coordinates.length;
            // Add the restaurant as a coordinate
            coordinates.push(depoLocation);
            // push the restaurant itself into the array
            keepTrack.push(pointHopper.depo);
          }
          restJobs.forEach(function(d, i) {
            // Add dropoff to list
            keepTrack.push(d);
            coordinates.push(d.geometry.coordinates);
            // if order not yet picked up, add a reroute
            if (needToPickUp && d.properties.orderTime > lastAtRestaurant) {
              distributions.push(restaurantIndex + ',' + (coordinates.length - 1));
            }
          });
        }
        // Set the profile to `driving`
        // Coordinates will include the current location of the truck,
        return 'https://api.mapbox.com/optimized-trips/v1/mapbox/driving/' + coordinates.join(';') + '?distributions=' + distributions.join(';') + '&overview=full&steps=true&geometries=geojson&source=first&access_token=' + mapboxgl.accessToken;
      }

      // This functions 1)create an object with new coordinate, 2)push it to pickups array
      function newDropoff(coords) {
        // Store the clicked point as a new GeoJSON feature with
        // two properties: `orderTime` and `key`
        var pt = turf.point(
          [coords.lng, coords.lat],
          {
            orderTime: Date.now(),
            key: Math.random()
          }
        );
        pickups.features.push(pt);
        pointHopper[pt.properties.key] = pt;
      }

      // Update location to pickup-symbols based on pickups.Refactored to just 1 time.
      function updatepickups(geojson) {
        map.getSource('pickups-symbol')
          .setData(geojson);
      }

      //Add Markers
      function updatemarker(geojson) {
        geojson.forEach(function(marker) {
          // create a HTML element for each feature
          var el = document.createElement('div');
          el.className = 'marker ' + marker.properties.color;

          // make a marker for each feature and add to the map
            new mapboxgl.Marker(el)
            .setLngLat(marker.geometry.coordinates)
            .setPopup(new mapboxgl.Popup({ offset: 25 }) // add popups
            .setHTML('<h5>' + marker.properties.code + '</h5><p>' + marker.properties.address + '</p><p>' + marker.properties.level + '</p>'))
            .addTo(map);
        });
      }

      function objectToArray(obj) {
        var keys = Object.keys(obj);
        var routeGeoJSON = keys.map(function(key) {
          return obj[key];
        });
        return routeGeoJSON;
      }

      console.log('script Ends')