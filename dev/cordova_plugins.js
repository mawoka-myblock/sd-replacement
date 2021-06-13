cordova.define('cordova/plugin_list', function(require, exports, module) {
module.exports = [
    {
        "file": "plugins/sentry-cordova/dist/js/sentry-cordova.bundle.js",
        "id": "sentry-cordova.Sentry",
        "pluginId": "sentry-cordova",
        "clobbers": [
            "Sentry"
        ]
    },
    {
        "file": "plugins/cordova-plugin-vibration/src/browser/Vibration.js",
        "id": "cordova-plugin-vibration.Vibration",
        "pluginId": "cordova-plugin-vibration",
        "merges": [
            "navigator"
        ]
    },
    {
        "file": "plugins/cordova-plugin-vibration/www/vibration.js",
        "id": "cordova-plugin-vibration.notification",
        "pluginId": "cordova-plugin-vibration",
        "merges": [
            "navigator"
        ]
    }
];
module.exports.metadata = 
// TOP OF METADATA
{
    "cordova-plugin-whitelist": "1.3.4",
    "sentry-cordova": "1.0.0-rc.0",
    "cordova-plugin-vibration": "3.1.1"
}
// BOTTOM OF METADATA
});