import { Controller } from "@hotwired/stimulus"

const options = {
  enableHighAccuracy: false, // normalement sur true, Précision typique : 5 à 20 mètres En extérieur, souvent < 10 mètres, et sur false : En ville dense : souvent 20–50 m En campagne : 100 m voir plus
  timeout: 10000, // essayer a 10 000 pour plus de temps
  maximumAge: 0
};
// Connects to data-controller="home"
export default class extends Controller {

  static values = {
    apiKey: String
  }
  connect() {
    // console.log("hello");
    // console.log(this.apiKeyValue)
    mapboxgl.accessToken = this.apiKeyValue;
    // console.log("1");
    this.getLocation();
  }

  async success(pos) {
    const crd = pos.coords;
    const lat = crd.latitude;
    const long = crd.longitude;
    // console.log("3");
    const city = await this.cityReverseGeocode(lat, long);
    const address = await this.addressReverseGeocode(lat, long);
    // console.log("Ville détectée :", city);
    // console.log(`Latitude : ${lat}`);
    // console.log(`Longitude: ${long}`);
    // console.log(pos);
    window.location.href = `/home?lat=${lat}&long=${long}&city=${city}&address=${address}`
  }

  error(err) {
    console.warn(`ERROR(${err.code}): ${err.message}`);
    window.location.href = `/home`
  }

  async cityReverseGeocode(lat, lng) {
    const url = `https://api.mapbox.com/geocoding/v5/mapbox.places/${lng},${lat}.json?access_token=${this.apiKeyValue}`;

    const response = await fetch(url);
    const data = await response.json();

    const cityFeature = data.features.find(f => f.place_type.includes("place"));
    const city = cityFeature ? cityFeature.text : null;

    // console.log("Ville :", city);
    return city;
  }

  async addressReverseGeocode(lat, lng) {
    const url = `https://api.mapbox.com/search/geocode/v6/reverse?longitude=${lng}&latitude=${lat}&types=address&access_token=${this.apiKeyValue}`;

    const response = await fetch(url);
    const data = await response.json();

    if (!data.features || data.features.length === 0) {
      console.log("Aucune adresse trouvée.");
      return null;
    }

    const feature = data.features[0];

    // Priorité : full_address → place_name → reconstruction
    const rawAddress =
      feature.properties?.full_address ||
      feature.place_name ||
      `${feature.properties?.address || ""} ${feature.text || ""}`.trim();

    if (!rawAddress) {
      console.log("Impossible de récupérer une adresse.");
      return null;
    }

    // Retire le pays (dernière partie séparée par une virgule)
    const addressWithoutCountry = rawAddress
      .split(",")
      .slice(0, -1)
      .join(",")
      .trim();

    // console.log("Adresse sans pays :", addressWithoutCountry);

    return addressWithoutCountry;
  }

  getLocation() {
    // console.log("2");
    navigator.geolocation.getCurrentPosition(this.success.bind(this), this.error, options);
  }
}
