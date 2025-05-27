// app/javascript/controllers/geolocation_controller.js
import { Controller } from "@hotwired/stimulus"
const options = {
  maximumAge: 0
};


// Connects to data-controller="geolocation"
export default class extends Controller {
  static values = { url: String }
  static targets = ["city", "country", "state", "address", "button", "buttonText"]

  search(event) {
    event.preventDefault();
    this.setLoading(true);
    navigator.geolocation.getCurrentPosition(this.success.bind(this), this.error.bind(this), options);
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
        this.setLoading(false);
      })
      .catch((error) => {
        console.error("Error fetching address:", error);
        this.setLoading(false);
      });
  }

  error(err) {
    console.warn(`ERROR(${err.code}): ${err.message}`);
    this.setLoading(false);
  }

  setLoading(isLoading) {
    this.buttonTarget.disabled = isLoading;
    this.buttonTextTarget.textContent = isLoading ? "Getting Location..." : "Get Current Location";
  }
}
