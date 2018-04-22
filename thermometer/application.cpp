#include <OneWire.h>
#include <spark-dallas-temperature.h>

long lastEvent = 0;
int eventInterval = 5 * 1000;

OneWire oneWire(D4);
DallasTemperature sensors(&oneWire);

void setup(void) {
   sensors.begin();
   Particle.publish("ready", PRIVATE);
}

void loop(void) {
   if(millis() - lastEvent > eventInterval) {
      sensors.requestTemperatures();
      String s(sensors.getTempFByIndex(0));
      Particle.publish("temp", s, PRIVATE);

      lastEvent = millis();
   }
}
