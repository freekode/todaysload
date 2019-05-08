using Toybox.WatchUi;
using Toybox.Time.Gregorian;
using LogMonkey as Log;

class DateField extends AbstractField {
	hidden var fieldId = "date";

	function initialize(result) {
        AbstractField.initialize(fieldId, convert(result));
    }

	hidden function convert(result) {
        var day = result["day"];
        var year = result["year"];

        var firstJanuary = Gregorian.moment({
            :year => year.toNumber(),
            :month => 1,
            :day => 1,
            :hour => 0,
            :minute => 0,
            :second => 0
        });

        var nDaysDuration = new Time.Duration(Gregorian.SECONDS_PER_DAY * (day.toNumber() - 1));
        var currentDate = firstJanuary.add(nDaysDuration);

        var dateInfo = Gregorian.info(currentDate, Time.FORMAT_SHORT);

        var dateString = Lang.format("$1$/$2$/$3$", [
            dateInfo.day,
            dateInfo.month,
            dateInfo.year
        ]);

        return dateString;
	}
}
