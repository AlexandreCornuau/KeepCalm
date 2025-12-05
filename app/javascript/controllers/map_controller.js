import { Controller } from "@hotwired/stimulus"

const options = {
  enableHighAccuracy: false, // normalement sur true, Précision typique : 5 à 20 mètres En extérieur, souvent < 10 mètres, et sur false : En ville dense : souvent 20–50 m En campagne : 100 m voir plus
  timeout: 5000, // essayer a 10 000 pour plus de temps
  maximumAge: 0
};
// Connects to data-controller="map"
export default class extends Controller {


  static values = {
    apiKey: String,
    markers: Array,
    interventionId: String,
    caseId: String,
    lat: String,
    long: String,
    interactive: Boolean,
    daeLat: String,
    daeLong: String
  }
  static targets = [
    "mapContainer"
  ]
  connect() {
    console.log(this.idValue);
    mapboxgl.accessToken = this.apiKeyValue
    console.log("markers", this.markersValue);
    console.log(this.hasMapContainerTarget)
    if (this.hasMapContainerTarget) {
      this.map = new mapboxgl.Map({
        container: this.mapContainerTarget,
        center: [parseFloat(this.longValue), parseFloat(this.latValue)],
        zoom: 15,
        maxZoom: 17,
        minZoom: 14,
        style: "mapbox://styles/mapbox/streets-v10",
        interactive: this.interactiveValue /////////////////////////////////////////////////////////////
      })
      new mapboxgl.Marker()
        .setLngLat([ this.longValue, this.latValue ])
        .addTo(this.map)
      new mapboxgl.Marker()
        .setLngLat([ parseFloat(this.daeLongValue), parseFloat(this.daeLatValue) ])
        .addTo(this.map)

      this.map.on("load", () => {
        const url = `https://api.mapbox.com/directions/v5/mapbox/walking/` +
          `${this.daeLongValue},${this.daeLatValue};${this.longValue},${this.latValue}` +
          `?geometries=geojson&access_token=${this.apiKeyValue}`;

        fetch(url)
          .then(response => response.json())
          .then(data => {
            const route = data.routes[0].geometry;

            this.map.addSource('route', {
              type: 'geojson',
              data: {
                type: "Feature",
                geometry: route
              }
            });

            this.map.addLayer({
              id: 'route-line',
              type: 'line',
              source: 'route',
              layout: {
                'line-join': 'round',
                'line-cap': 'round'
              },
              paint: {
                'line-color': '#ff0505',
                'line-width': 8
              }
            });
          });
      });
    }

    // this.#addMarkersToMap()
  }

  // #addMarkersToMap() {
  // this.markersValue.forEach((marker) => {
  //   new mapboxgl.Marker()
  //     .setLngLat([ marker.long, marker.lat ])
  //     .addTo(this.map)
  // })
  // }

  async success(pos) {
    const crd = pos.coords;
    const lat = crd.latitude;
    const long = crd.longitude;

    const city = await this.reverseGeocode(lat, long);
    console.log("Ville détectée :", city);
    console.log('Your current position is:');
    console.log(`Latitude : ${lat}`);
    console.log(`Longitude: ${long}`);
    console.log(`More or less ${crd.accuracy} meters.`);
    console.log(pos);
    window.location.href = `/interventions/${this.interventionIdValue}?lat=${lat}&long=${long}&case_id=${this.caseIdValue}&city=${city}`
  }

  error(err) {
    console.warn(`ERROR(${err.code}): ${err.message}`);
  }

  async reverseGeocode(lat, lng) {
    const url = `https://api.mapbox.com/geocoding/v5/mapbox.places/${lng},${lat}.json?access_token=${this.apiKeyValue}`;

    const response = await fetch(url);
    const data = await response.json();

    // Récupère la ville (place_name ou "place" dans features)
    const cityFeature = data.features.find(f => f.place_type.includes("place"));
    const city = cityFeature ? cityFeature.text : null;

    console.log("Ville :", city);
    return city;
  }

  getLocation() {
    navigator.geolocation.getCurrentPosition(this.success.bind(this), this.error, options);
  }
}
