/* -----------------------------------------------------------
This example shows a lot of different features. As configured here
it will check for a good GPS fix every 10 minutes and publish that data
if there is one. If not, it will save you data by staying quiet. It also
registers 3 Particle.functions for changing whether it publishes,
reading the battery level, and manually requesting a GPS reading.
---------------------------------------------------------------*/

// Getting the library
#include <application.h>
#include <TinyGPS++.h>

long last = 0;
int delays = 1;

TinyGPSPlus gps;

int min2mill(int min);

void setup() {
   Serial1.begin(9600);
   Particle.publish("ready", PRIVATE);
}

void loop() {
   if(Serial1.available()) {
      auto str = Serial1.readStringUntil('\n');
      for(int i = 0; i < str.length(); ++i)
         gps << str.charAt(i);
   }

   if(millis() - last > min2mill(delays)) {
      auto location = gps.location;
      if(location.isValid() && location.isUpdated()) {
         auto str = String::format("%d:%d", location.lat(), location.lng());
         Particle.publish("pos", str, PRIVATE);
      }
      else {
         Particle.publish("err", "invalid location", PRIVATE);
      }

      last = millis();
   }
}

int min2mill(int min) {
   return 1000 * 60 * min;
}
