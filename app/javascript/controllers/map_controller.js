import { Controller } from "@hotwired/stimulus"

const options = {
  enableHighAccuracy: true,
  timeout: 5000,
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
    long: String
  }
  static targets = [
    "mapContainer"
  ]
  connect() {
    console.log(this.idValue);
    mapboxgl.accessToken = this.apiKeyValue
    console.log("markers", this.markersValue);
    console.log(this.hasMapContainerTarget)
    console.log(this.longValue);
    if (this.hasMapContainerTarget) {
      this.map = new mapboxgl.Map({
        container: this.mapContainerTarget,
        center: [parseFloat(this.longValue), parseFloat(this.latValue)],
        zoom: 13.5,
        maxZoom: 16,
        minZoom: 13,
        style: "mapbox://styles/mapbox/streets-v10"
      })
      new mapboxgl.Marker()
        .setLngLat([ this.longValue, this.latValue ])
        .addTo(this.map)
    }

    // this.#addMarkersToMap()
  }

  #addMarkersToMap() {
  this.markersValue.forEach((marker) => {
    new mapboxgl.Marker()
      .setLngLat([ marker.long, marker.lat ])
      .addTo(this.map)
  })
  }
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
