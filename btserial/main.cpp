// modified version of
// https://github.com/rickkas7/AssetTrackerRK/blob/master/examples/1_SimpleGPS/1_SimpleGPS.cpp
//

#include <application.h>
#include "Serial5/Serial5.h"
#include "TinyGPS++.h"

SYSTEM_MODE(MANUAL);
SYSTEM_THREAD(ENABLED);

void displayInfo(); // forward declaration

const unsigned long PUBLISH_PERIOD = 120000;
const unsigned long SERIAL_PERIOD = 5000;
const unsigned long MAX_GPS_AGE_MS = 10000; // GPS location must be newer than this to be considered valid

// The TinyGPS++ object
TinyGPSPlus gps;
unsigned long lastSerial = 0;
unsigned long lastPublish = 0;
unsigned long startFix = 0;
bool gettingFix = false;

void setup()
{
   Serial5.begin(9600);

   // The GPS module on the AssetTracker is connected to Serial1 and D6
   Serial1.begin(9600);

   // Settings D6 LOW powers up the GPS module
   pinMode(D6, OUTPUT);
   digitalWrite(D6, LOW);
   startFix = millis();
   gettingFix = true;
}

void loop()
{
   while (Serial1.available() > 0) {
      if (gps.encode(Serial1.read())) {
         displayInfo();
      }
   }

}

void displayInfo()
{
   if (millis() - lastSerial >= SERIAL_PERIOD) {
      lastSerial = millis();

      char buf[128];
      if (gps.location.isValid() && gps.location.age() < MAX_GPS_AGE_MS) {
         snprintf(buf, sizeof(buf), "%f,%f,%f", gps.location.lat(), gps.location.lng(), gps.altitude.meters());
         if (gettingFix) {
            gettingFix = false;
            unsigned long elapsed = millis() - startFix;
            Serial5.printlnf("%lu milliseconds to get GPS fix", elapsed);
         }
      }
      else {
         strcpy(buf, "no location");
         if (!gettingFix) {
            gettingFix = true;
            startFix = millis();
         }
      }
      Serial5.println(buf);

      if (Particle.connected()) {
         if (millis() - lastPublish >= PUBLISH_PERIOD) {
            lastPublish = millis();
            Particle.publish("gps", buf);
         }
      }
   }
}
