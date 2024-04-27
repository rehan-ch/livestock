// app/javascript/controllers/geolocation_controller.js
import { Controller } from "@hotwired/stimulus"
const options = {
  enableHighAccuracy: true,
  maximumAge: 0
};


// Connects to data-controller="geolocation"
export default class extends Controller {
  static values = { url: String }
  static targets = ["city", "country", "state", "address"]

  search(event) {
    event.preventDefault();
    navigator.geolocation.getCurrentPosition(this.success.bind(this), this.error, options);
  }
  
  success(pos) {
    const crd = pos.coords;
    // redirect with coordinates in params
    const csrfToken = document
    .querySelector('meta[name="csrf-token"]')
    .getAttribute("content");
    fetch("/dashboard/my_ads/get_address", {
      method: "POST",
      headers: {
        Accept: "application/json",
        "Content-Type": "application/json",
        "X-CSRF-Token": csrfToken,
      },
      body: JSON.stringify({ lat: crd.latitude, long: crd.longitude }),
    })
    .then((response) => response.json())
      .then((data) => {
        console.log(data);
        this.cityTarget.value = data.city
        this.countryTarget.value = data.country
        this.addressTarget.value = data.address
        this.stateTarget.value = data.state
      });
    }
    error(err) {
      console.warn(`ERROR(${err.code}): ${err.message}`);
    }
  }
