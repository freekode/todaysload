using Toybox.WatchUi;

class AttentionTools {
    function vibrate() {
        if (Attention has :vibrate) {
            var vibeData = [new Attention.VibeProfile(50, 500)];
            Attention.vibrate(vibeData);
        }
    }

    function backlight() {
        if (Attention has :backlight) {
            Attention.backlight(true);
        }
    }
}
