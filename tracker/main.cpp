#include <application.h>
#include <TinyGPS++.h>

long lastEvent = 0;
int eventInterval = 5 * 1000;

TinyGPSPlus gps;

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

   if(millis() - lastEvent > eventInterval) {
      auto location = gps.location;
      if(location.isValid() && location.isUpdated()) {
         auto lat = String(location.lat(), 6);
         auto lon = String(location.lng(), 6);
         auto str = String::format("%s:%s", lat.c_str(), lon.c_str());

         Particle.publish("pos", str, PRIVATE);
      }
      lastEvent = millis();
   }
}
