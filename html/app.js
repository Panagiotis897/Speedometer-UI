document.addEventListener("DOMContentLoaded", () => {
    window.addEventListener("message", (e) => {
        if (e.data.action === "show") {
            $(".container").removeClass("hidden");

            let speed = e.data.isMetric ? e.data.speed * 3.6 : e.data.speed * 2.236936;
            let measurementType = e.data.isMetric ? "km/h" : "mph";
            let rpm = e.data.rpm * 100;

            $(".speed").text(speed.toFixed(0) + " " + measurementType);
            $(".measurementType").text("");

            $(".indicator").css("width", rpm + "%").text("");

            $(".gear").text(e.data.gear);
        } else if (e.data.action === "hide") {
            $(".container").addClass("hidden");
        }
    });
});