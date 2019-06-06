using Toybox.Application;

class SportTypesRepository {
	hidden var app;
	hidden var fieldsMap;

	function initialize() {
		app = Application.getApp();
	}

	function getSportTypes() {
		var ride = "ride";
		var run = "run";
		var swim = "swim";
		var gym = "gym";
		var walk = "walk";

		var useRide = app.getProperty("useRide");
        var useRun = app.getProperty("useRun");
		var useSwim = app.getProperty("useSwim");
        var useGym = app.getProperty("useGym");
        var useWalk = app.getProperty("useWalk");

		var sportTypes = [];

		if (useRide) {
			sportTypes.push(ride);
		}
		if (useRun) {
            sportTypes.push(run);
        }
		if (useSwim) {
            sportTypes.push(swim);
        }
		if (useGym) {
            sportTypes.push(gym);
        }
		if (useWalk) {
            sportTypes.push(walk);
        }

        return sportTypes;
    }
}
