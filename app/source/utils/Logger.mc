using Toybox.System;

(:debug:background)
class Logger {
    function log(source, message) {
        var fullMessage = "[" + Logger.getTimeMessage() + "] [" + source + "] " + message;
        System.println(fullMessage);
    }

    function getTimeMessage() {
        var clockTime = System.getClockTime();

        return clockTime.hour.format("%02d") + ":" +
            clockTime.min.format("%02d") + ":" +
            clockTime.sec.format("%02d");
    }
}

(:release:background)
class Logger {
    function log(source, message) {
    }
}
