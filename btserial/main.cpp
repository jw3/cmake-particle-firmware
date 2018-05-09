#include <application.h>

int counter = 0;

void setup() {
   Serial1.begin(9600);
}

void loop() {
   Serial1.printlnf("testing %d", ++counter);

   while(Serial1.available()) {
      auto str = Serial1.readStringUntil('\n');
      str += " (echo)";
      Serial1.println(str);
   }

   delay(1000);
}
